import 'package:backup/controller/cart_controller.dart';
import 'package:backup/models/product.dart';
import 'package:backup/screems/ordersumarypage_screem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IceCreamPage extends StatelessWidget {
  final List<Product> iceCreams;

  IceCreamPage({required this.iceCreams});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Helados'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderSummaryPage(
                    tableNumber: "1", 
                    cartItems: cartController.cartItems,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: iceCreams.length,
        itemBuilder: (context, index) {
          final iceCream = iceCreams[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(
                iceCream.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(iceCream.name),
              subtitle: Text('\$${iceCream.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  cartController.addToCart(iceCream);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${iceCream.name} añadido al carrito'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}