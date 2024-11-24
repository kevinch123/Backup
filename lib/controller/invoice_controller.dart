import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../services/database_helper.dart';
import '../models/product.dart';
import '../models/invoice.dart';

class InvoiceController with ChangeNotifier {
  final List<Product> _invoiceItems = [];
  double _discount = 0.0;
  String _paymentMethod = "Efectivo";

  // Métodos para manejar los productos en la factura
  void addProduct(Product product, int quantity) {
    final existingItemIndex =
        _invoiceItems.indexWhere((item) => item.name == product.name);
    if (existingItemIndex != -1) {
      _invoiceItems[existingItemIndex].quantity += quantity;
    } else {
      product.quantity = quantity;
      _invoiceItems.add(product);
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    _invoiceItems.removeWhere((item) => item.name == product.name);
    notifyListeners();
  }

  void setDiscount(double discount) {
    _discount = discount;
    notifyListeners();
  }

  void setPaymentMethod(String paymentMethod) {
    _paymentMethod = paymentMethod;
    notifyListeners();
  }

  void clearInvoice() {
    _invoiceItems.clear();
    _discount = 0.0;
    _paymentMethod = "Efectivo";
    notifyListeners();
  }

  Invoice generateInvoice(List<Product> cartItems) {
    double subtotal = cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
    double total = subtotal * (1 - _discount);
    return Invoice(
      items: cartItems,
      subtotal: subtotal,
      discount: _discount,
      total: total, 
    );
  }

  // Guardar la factura en la base de datos
  Future<void> saveInvoiceToDatabase(Invoice invoice) async {
    await DatabaseHelper().insertInvoice(invoice);
    clearInvoice();
  }

  // Método para crear el PDF con la fuente personalizada
  static Future<String> createPDF(double totalDay, int numInvoices) async {
    final pdf = pw.Document();

    // Cargar la fuente personalizada
    final fontRegular = await _loadFont('assets/fonts/Roboto-Regular.ttf'); // Correcta ruta

    // Crear el PDF con la fuente personalizada
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              'Total del Día: \$${totalDay.toStringAsFixed(2)}\nNúmero de Facturas: $numInvoices',
              style: pw.TextStyle(font: fontRegular, fontSize: 18),
            ),
          );
        },
      ),
    );

    // Obtener el directorio de la aplicación para guardar el PDF
    final outputDirectory = await getTemporaryDirectory();
    final filePath = '${outputDirectory.path}/reporte_diario.pdf';

    // Guardar el archivo PDF
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Retornar la ruta del archivo PDF generado
    return filePath;
  }

  // Método para cargar la fuente desde los activos
  static Future<pw.Font> _loadFont(String assetPath) async {
    final byteData = await rootBundle.load(assetPath); // Cargar el archivo de la fuente
    final fontData = byteData.buffer.asUint8List(); // Convertir ByteData a lista de bytes
    final byteDataForFont = ByteData.sublistView(fontData); // Convertir a ByteData
    return pw.Font.ttf(byteDataForFont); // Pasar como ByteData
  }



  // Getters
  List<Product> get invoiceItems => _invoiceItems;

  double get subtotal => generateInvoice(_invoiceItems).subtotal;

  double get total => generateInvoice(_invoiceItems).total;

  double get discount => _discount;

  String get paymentMethod => _paymentMethod;
}
