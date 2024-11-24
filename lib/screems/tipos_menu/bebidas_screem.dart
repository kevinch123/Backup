import 'package:backup/controller/cart_controller.dart';
import 'package:backup/models/product.dart';
import 'package:backup/screems/ordersumarypage_screem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DrinksPage extends StatelessWidget {
  final List<Product> drinks;

  DrinksPage({required this.drinks});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bebidas'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navegar a la pantalla del carrito o resumen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderSummaryPage(
                    tableNumber: "1", // Cambiar por la mesa correspondiente
                    cartItems: cartController.cartItems,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          final drink = drinks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(
                drink.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(drink.name),
              subtitle: Text('\$${drink.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  cartController.addToCart(drink);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${drink.name} añadido al carrito'),
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
