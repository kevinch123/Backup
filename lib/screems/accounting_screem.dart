import 'package:backup/controller/email_controller.dart';
import 'package:flutter/material.dart';
import 'package:backup/controller/invoice_controller.dart';
import 'package:backup/services/database_helper.dart';
import '../models/invoice.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class AccountingScreen extends StatefulWidget {
  @override
  _AccountingScreenState createState() => _AccountingScreenState();
}

class _AccountingScreenState extends State<AccountingScreen> {
  double totalDay = 0.0; // Total calculado dinámicamente
  List<Invoice> invoices = []; // Lista de facturas del día

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final dbHelper = DatabaseHelper();
    final fetchedInvoices = await dbHelper.getInvoices();

    print('Facturas recuperadas:');
    fetchedInvoices.forEach((invoice) {
      print('Subtotal: ${invoice.subtotal}, Total: ${invoice.total}');
    });

    setState(() {
      invoices = fetchedInvoices;
      totalDay = fetchedInvoices.fold(0.0, (sum, invoice) => sum + invoice.total);
    });
  }

  // Método para generar el PDF y enviarlo por correo
  Future<void> _sendEmailWithPDF() async {
    // Primero generamos el PDF y obtenemos la ruta
    final pdfPath = await InvoiceController.createPDF(totalDay, invoices.length);
    
    // Enviar el correo con el PDF adjunto
    final emailController = EmailController();
    emailController.sendEmailWithAttachment(pdfPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contabilidad'),
        backgroundColor: Color(0xFF7E57C2),
        foregroundColor: Colors.white

      ),
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Título y textos superiores
          Text(
            'Total del Día: \$${totalDay.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Últimas Facturas:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          
          // Lista de facturas, centrada
          Expanded(
            child: invoices.isEmpty
                ? Center(child: Text('No hay facturas disponibles.'))
                : ListView.builder(
                    itemCount: invoices.length,
                    itemBuilder: (context, index) {
                      final invoice = invoices[index];
                      return ListTile(
                        title: Text('Factura #${index + 1}'),
                        subtitle: Text('Total: \$${invoice.total}'),
                        trailing: Text('Descuento: ${(invoice.discount * 100).toStringAsFixed(1)}%'),
                      );
                    },
                  ),
          ),

          // Espaciador para empujar los botones hacia abajo
          Spacer(),

          // Botones alineados al final de la pantalla
          Padding(
            padding: const EdgeInsets.all(20.0), // Espacio alrededor de los botones
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea los botones a la izquierda
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF03A9F4), // Color azul claro
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Reducido el padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Reduje el borderRadius
                    ),
                    minimumSize: Size(180, 50), // Botón más pequeño
                  ),
                  onPressed: _sendEmailWithPDF, // Llamar al método para generar el PDF y enviarlo por correo
                  child: Text(
                    'Enviar por correo',
                    style: TextStyle(
                      fontFamily: 'Roboto', // Asegúrate de que Roboto esté configurado en tu proyecto
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // Reduje el tamaño de la fuente
                    ),
                  ),
                ),
                SizedBox(height: 16), // Reduje el espacio entre los botones
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50), // Color verde suave
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Reducido el padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Reduje el borderRadius
                    ),
                    minimumSize: Size(180, 50), // Botón más pequeño
                  ),
                  onPressed: () async {
                    await InvoiceController.createPDF(totalDay, invoices.length);
                  },
                  child: Text(
                    'Generar PDF',
                    style: TextStyle(
                      fontFamily: 'Roboto', // Asegúrate de que Roboto esté configurado en tu proyecto
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // Reduje el tamaño de la fuente
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),

    );
  }
}