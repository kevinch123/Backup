import 'package:backup/controller/products_controller.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class CreationDishes extends StatefulWidget {
  @override
  _CreationDishesState createState() => _CreationDishesState();
}

class _CreationDishesState extends State<CreationDishes> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  String _selectedType = 'Bebidas';

  Future<void> _addProduct() async {
    final String name = _nameController.text;
    final double? price = double.tryParse(_priceController.text);
    final String imageUrl = _imageUrlController.text;
    final String type = _selectedType;

    if (name.isNotEmpty && price != null && imageUrl.isNotEmpty) {
      final product = Product(
        name: name,
        price: price,
        imageUrl: imageUrl,
        type: type,
      );

      try {
        await menuController.addProduct(product);
        _nameController.clear();
        _priceController.clear();
        _imageUrlController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Producto agregado exitosamente.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar producto: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text(
          'Creación de Platillos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/img/parrilla.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.white), 
                    decoration: InputDecoration(
                      labelText: 'Nombre del Producto',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), 
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange), 
                      ),
                    ),
                  ),
                  SizedBox(height: 10), 
                  TextField(
                    controller: _priceController,
                    style: TextStyle(color: Colors.white), 
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), 
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange), 
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),  
                  TextField(
                    controller: _imageUrlController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'URL de Imagen',
                      labelStyle: TextStyle(color: Colors.white),      
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), 
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange), 
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                                    Row(
                    children: [
                      Text(
                        'Tipo:',
                        style: TextStyle(color: Colors.white), 
                      ),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: _selectedType,
                        dropdownColor: Colors.black, 
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedType = newValue!;
                          });
                        },
                        items: <String>[
                          'Bebidas',
                          'Comida Rapida',
                          'Heladería',
                          'Cafetería',
                          'Adicionales'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), 
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
                    ),
                    onPressed: _addProduct,
                    child: Text(
                      'Agregar Producto',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold, 
                      ),
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
