import 'package:backup/controller/cart_controller.dart';
import 'package:backup/models/product.dart';
import 'package:backup/screems/ordersumarypage_screem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FastFoodPage extends StatelessWidget {
  final List<Product> fastFoods;

  FastFoodPage({required this.fastFoods});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comida Rápida'),
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
        itemCount: fastFoods.length,
        itemBuilder: (context, index) {
          final fastFood = fastFoods[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(
                fastFood.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(fastFood.name),
              subtitle: Text('\$${fastFood.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  cartController.addToCart(fastFood);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${fastFood.name} añadido al carrito'),
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
