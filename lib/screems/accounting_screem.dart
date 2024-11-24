import 'package:backup/services/database_helper.dart';
import 'package:flutter/material.dart';
import '../models/invoice.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contabilidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de historial de facturas
                Navigator.pushNamed(context, '/factura_history');
              },
              child: Text('Historial de Facturas'),
            ),
            SizedBox(height: 20),
            Text(
              'Total del Día: \$${totalDay.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Últimas Facturas:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
          ],
        ),
      ),
    );
  }
}
