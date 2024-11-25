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
        title: Text(
          'Café',
          style: TextStyle(
            color: Colors.white, // Texto del título más oscuro (negro)
          ),
        ),
        backgroundColor: Colors.transparent, // Fondo transparente para que se vea la imagen
        elevation: 0, // Sin sombra
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
      extendBodyBehindAppBar: true, // Extiende el cuerpo detrás del AppBar
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/img/parrilla.jpg', // Aquí pon la imagen que quieras usar
              fit: BoxFit.cover, // Asegura que cubra toda la pantalla
            ),
          ),
          // Contenido principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: drinks.length,
                      itemBuilder: (context, index) {
                        final drink = drinks[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          color: Colors.black.withOpacity(0.6), // Fondo más oscuro con opacidad
                          child: ListTile(
                            leading: Image.network(
                              drink.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              drink.name,
                              style: TextStyle(color: Colors.white), // Texto blanco para mayor contraste
                            ),
                            subtitle: Text(
                              '\$${drink.price.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white), // Texto blanco
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white), // Íconos blancos
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
