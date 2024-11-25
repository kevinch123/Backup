import 'package:backup/controller/cart_controller.dart';
import 'package:backup/models/product.dart';
import 'package:backup/screems/ordersumarypage_screem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExtrasPage extends StatelessWidget {
  final List<Product> extraItems;

  ExtrasPage({required this.extraItems});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Extras',
          style: TextStyle(
            color: Colors.white, // Título más oscuro
          ),
        ),
        backgroundColor: Colors.transparent, // Fondo transparente
        elevation: 0, // Sin sombra
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black), // Ícono del carrito más oscuro
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
                      itemCount: extraItems.length,
                      itemBuilder: (context, index) {
                        final extra = extraItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          color: Colors.black.withOpacity(0.6), // Fondo oscuro con opacidad
                          child: ListTile(
                            leading: Image.network(
                              extra.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              extra.name,
                              style: TextStyle(color: Colors.white), // Texto blanco para mayor contraste
                            ),
                            subtitle: Text(
                              '\$${extra.price.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white), // Texto blanco
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white), // Íconos blancos
                              onPressed: () {
                                cartController.addToCart(extra);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${extra.name} añadido al carrito'),
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
