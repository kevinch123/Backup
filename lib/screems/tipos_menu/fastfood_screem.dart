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
        title: Text(
          'Comida Rápida',
          style: TextStyle(
            color: Colors.black, 
          ),
        ),
        backgroundColor: Colors.orange, 
        elevation: 0, 
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black), 
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
      extendBodyBehindAppBar: true, 
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: fastFoods.length,
                      itemBuilder: (context, index) {
                        final fastFood = fastFoods[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          color: Colors.white.withOpacity(0.2), 
                          child: ListTile(
                            leading: Image.network(
                              fastFood.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              fastFood.name,
                              style: TextStyle(color: Colors.white), 
                            ),
                            subtitle: Text(
                              '\$${fastFood.price.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white), 
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white), 
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
