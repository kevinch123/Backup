import 'package:backup/screems/home_screem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/invoice_controller.dart';
import '../models/product.dart';

class OrderSummaryPage extends StatefulWidget {
  final String tableNumber;
  final List<Product> cartItems;

  OrderSummaryPage({required this.tableNumber, required this.cartItems});

  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final invoiceController = Provider.of<InvoiceController>(context);
    final invoice = invoiceController.generateInvoice(widget.cartItems);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen de la Orden - Mesa ${widget.tableNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalle de Productos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: invoice.items.length,
                itemBuilder: (context, index) {
                  final product = invoice.items[index];
                  return ListTile(
                    leading: Image.network(
                      product.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Text(
                      'Cantidad: ${product.quantity} | Precio: \$${product.price.toStringAsFixed(2)}',
                    ),
                    trailing: Text(
                      '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text(
              'Subtotal: \$${invoice.subtotal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Descuento Predeterminado: ${invoice.discount * 100}%',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Descuento Adicional (%):',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '0',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        final customDiscount = double.tryParse(value) ?? 0.0;
                        invoiceController.setDiscount(customDiscount / 100); // Actualiza el descuento
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Total: \$${invoice.total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await invoiceController.saveInvoiceToDatabase(invoice);

                  setState(() {
                    widget.cartItems.clear();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Factura guardada exitosamente.')),
                  );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false, 
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50), 
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), 
                  ),
                  minimumSize: Size(200, 60), 
                ),
                child: Text(
                  'Guardar Factura',
                  style: TextStyle(fontSize: 18), 
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
