import 'package:backup/controller/cart_controller.dart';
import 'package:backup/models/product.dart';
import 'package:backup/screems/ordersumarypage_screem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeePage extends StatelessWidget {
  final List<Product> coffeeItems;

  CoffeePage({required this.coffeeItems});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Café'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navegar a la pantalla del carrito o resumen
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
        itemCount: coffeeItems.length,
        itemBuilder: (context, index) {
          final coffee = coffeeItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(
                coffee.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(coffee.name),
              subtitle: Text('\$${coffee.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  cartController.addToCart(coffee);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${coffee.name} añadido al carrito'),
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
