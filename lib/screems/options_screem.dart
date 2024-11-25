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

  Options({required this.tableNumber}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones de Mesa'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Image.asset(
            'assets/img/parrilla.jpg', 
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
    
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0), 
                child: Column(
                  children: [
                    Text(
                      'Mesa: $tableNumber', 
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 20),

                    Center(
                      child: Column(
                        children: [
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.withOpacity(0.7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80), 
                              textStyle: TextStyle(fontSize: 20), 
                            ),
                            child: Text('Bebidas'),
                          ),
                          SizedBox(height: 10),

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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.withOpacity(0.7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 73),
                              textStyle: TextStyle(fontSize: 20),
                            ),
                            child: Text('Heladería'),
                          ),
                          SizedBox(height: 10),

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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.withOpacity(0.7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 75),
                              textStyle: TextStyle(fontSize: 20),
                            ),
                            child: Text('Cafetería'),
                          ),
                          SizedBox(height: 10),

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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.withOpacity(0.7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 73),
                              textStyle: TextStyle(fontSize: 20),
                            ),
                            child: Text('Fast Food'),
                          ),
                          SizedBox(height: 10),

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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.withOpacity(0.7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 65),
                              textStyle: TextStyle(fontSize: 20),
                            ),
                            child: Text('Adicionales'),
                          ),
                          SizedBox(height: 40),

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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 90),
                              textStyle: TextStyle(fontSize: 20),
                            ),
                            child: Text('Hecho'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}