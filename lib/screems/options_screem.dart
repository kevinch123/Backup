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
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF7E57C2),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones de Mesa'),
        backgroundColor: Color(0xFF7E57C2),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Mesa: $tableNumber',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),

                // Botón Bebidas
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final drinks = await menuController.fetchProductsByType('Bebidas');
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
                  style: buttonStyle,
                  child: Text('Bebidas', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),

                // Botón Heladería
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final iceCreams = await menuController.fetchProductsByType('Heladería');
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
                  style: buttonStyle,
                  child: Text('Heladería', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),

                // Botón Cafetería
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final coffee = await menuController.fetchProductsByType('Cafetería');
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
                  style: buttonStyle,
                  child: Text('Cafetería', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),

                // Botón Fast Food
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final fastFoods = await menuController.fetchProductsByType('Fast Food');
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
                  style: buttonStyle,
                  child: Text('Fast Food', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),

                // Botón Adicionales
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final extras = await menuController.fetchProductsByType('Adicionales');
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
                  style: buttonStyle,
                  child: Text('Adicionales', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 40),

                // Botón Hecho
                ElevatedButton(
                  onPressed: () {
                    final cartItems = Provider.of<Cart>(context, listen: false).cartItems;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSummaryPage(
                          tableNumber: tableNumber,
                          cartItems: cartItems,
                        ),
                      ),
                    );
                  },
                  style: buttonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: Text('Hecho', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
