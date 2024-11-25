import 'package:backup/controller/email_controller.dart';
import 'package:flutter/material.dart';
import 'package:backup/controller/invoice_controller.dart';
import 'package:backup/services/database_helper.dart';
import '../models/invoice.dart';

class AccountingScreen extends StatefulWidget {
  @override
  _AccountingScreenState createState() => _AccountingScreenState();
}

class _AccountingScreenState extends State<AccountingScreen> {
  double totalDay = 0.0; 
  List<Invoice> invoices = []; 

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

  Future<void> _sendEmailWithPDF() async {
    final pdfPath = await InvoiceController.createPDF(totalDay, invoices.length);
    
    final emailController = EmailController();
    emailController.sendEmailWithAttachment(pdfPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contabilidad'),
        backgroundColor: Color(0xFF7E57C2),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/img/parrilla.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50), 
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _sendEmailWithPDF,
                    child: Text('Enviar por correo'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFC107), 
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await InvoiceController.createPDF(totalDay, invoices.length);
                    },
                    child: Text('Generar PDF'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Total del Día: \$${totalDay.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70, 
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Últimas Facturas:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70, 
                    ),
                  ),
                  Expanded(
                    child: invoices.isEmpty
                        ? Center(child: Text('No hay facturas disponibles.', style: TextStyle(color: Colors.white70)))
                        : ListView.builder(
                            itemCount: invoices.length,
                            itemBuilder: (context, index) {
                              final invoice = invoices[index];
                              return ListTile(
                                title: Text('Factura #${index + 1}', style: TextStyle(color: Colors.white70)), 
                                subtitle: Text('Total: \$${invoice.total}', style: TextStyle(color: Colors.white70)), 
                                trailing: Text('Descuento: ${(invoice.discount * 100).toStringAsFixed(1)}%', style: TextStyle(color: Colors.white70)), 
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}