import 'package:flutter/material.dart';
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
    // Calcula el total basado en el descuento adicional
    double subtotal = cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
    double total = subtotal * (1 - _discount);
    return Invoice(
      items: cartItems,
      subtotal: subtotal,
      discount: _discount,
      total: total, 
    );
  }


  // Persistir la factura generada en la base de datos
//Future<void> saveInvoiceToDatabase() async {
  //final invoice = generateInvoice(_invoiceItems);  // Genera la factura con subtotal y total calculados
  //await DatabaseHelper().insertInvoice(invoice);  // Guarda la factura en la base de datos
  //clearInvoice();  // Limpia la factura después de guardarla
//}
Future<void> saveInvoiceToDatabase(Invoice invoice) async {
  await DatabaseHelper().insertInvoice(invoice);
  clearInvoice();
}



  // Obtener el historial de facturas desde la base de datos
  Future<List<Invoice>> getInvoiceHistory() async {
    return await DatabaseHelper().getInvoices();
  }

  

  // Getters
  List<Product> get invoiceItems => _invoiceItems;

  double get subtotal => generateInvoice(_invoiceItems).subtotal;

  double get total => generateInvoice(_invoiceItems).total;

  double get discount => _discount;

  String get paymentMethod => _paymentMethod;
}
