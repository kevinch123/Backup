import 'package:backup/controller/cart_controller.dart';
import 'package:backup/controller/products_controller.dart';
import 'package:backup/screems/ordersumarypage_screem.dart';
import 'package:backup/screems/tipos_menu/bebidas_screem.dart';
import 'package:backup/screems/tipos_menu/fastfood_screem.dart';
import 'package:backup/screems/tipos_menu/coffee_screem.dart';
import 'package:backup/screems/tipos_menu/icecream_screem.dart';
import 'package:backup/screems/tipos_menu/extras_screem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Options extends StatelessWidget {
  final String tableNumber;

  Options({required this.tableNumber}); // Recibe el número de mesa

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones de Mesa'),
        backgroundColor: Color(0xFF7E57C2),
        foregroundColor: Colors.white
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding general para el contenido
          child: Column(
            children: [
              Text(
                'Mesa: $tableNumber', // Muestra el número de la mesa
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Botón Bebidas
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Obtiene los productos de Firebase filtrados por tipo
                    final drinks = await menuController.fetchProductsByType('Bebidas');

                    // Navegar a DrinksPage pasando los productos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrinksPage(drinks: drinks),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al cargar bebidas: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7E57C2), 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Bebidas'),
              ),
              SizedBox(height: 10),

              // Botón Heladería
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Obtiene los productos de Firebase filtrados por tipo
                    final iceCreams = await menuController.fetchProductsByType('Heladería');

                    // Navegar a IceCreamPage pasando los productos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IceCreamPage(iceCreams: iceCreams),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al cargar helados: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7E57C2), 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Heladería'),
              ),
              SizedBox(height: 10),

              // Botón Cafetería
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Obtiene los productos de Firebase filtrados por tipo
                    final coffee = await menuController.fetchProductsByType('Cafetería');

                    // Navegar a CoffeePage pasando los productos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoffeePage(coffeeItems: coffee),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al cargar cafetería: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7E57C2), 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Cafetería'),
              ),
              SizedBox(height: 10),

              // Botón Fast Food
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Obtiene los productos de Firebase filtrados por tipo
                    final fastFoods = await menuController.fetchProductsByType('Fast Food');

                    // Navegar a FastFoodPage pasando los productos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FastFoodPage(fastFoods: fastFoods),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al cargar Fast Food: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7E57C2), 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Fast Food'),
              ),
              SizedBox(height: 10),

              // Botón Adicionales
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Obtiene los productos de Firebase filtrados por tipo
                    final extras = await menuController.fetchProductsByType('Adicionales');

                    // Navegar a ExtrasPage pasando los productos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExtrasPage(extraItems: extras),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al cargar adicionales: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7E57C2), 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Adicionales'),
              ),
              SizedBox(height: 40),

              // Botón Hecho (colocado más abajo)
              ElevatedButton(
                onPressed: () {
                  final cartItems = Provider.of<Cart>(context, listen: false).cartItems;

                  // Navegar a la pantalla de resumen de la orden
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSummaryPage(
                        tableNumber: tableNumber, // Número real de la mesa
                        cartItems: cartItems,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Hecho'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}