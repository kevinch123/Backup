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
        title: Text(
          'Café',
          style: TextStyle(
            color: Colors.white, 
          ),
        ),
        backgroundColor: Colors.transparent, 
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
                      itemCount: coffeeItems.length,
                      itemBuilder: (context, index) {
                        final coffee = coffeeItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          color: Colors.black.withOpacity(0.6), 
                          child: ListTile(
                            leading: Image.network(
                              coffee.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              coffee.name,
                              style: TextStyle(color: Colors.white), 
                            ),
                            subtitle: Text(
                              '\$${coffee.price.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white), 
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
