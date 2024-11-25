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
        backgroundColor: Colors.transparent, // Transparente para que se vea la imagen
        elevation: 0, // Sin sombra
        title: const Text(
          'Creación de Platillos',
          style: TextStyle(
            fontSize: 32, // Tamaño grande
            fontWeight: FontWeight.bold, // Negrita
            color: Colors.orange, // Color personalizado
          ),
        ),
        centerTitle: true, // Centra el título
      ),
      extendBodyBehindAppBar: true, // Extiende el cuerpo detrás del AppBar
      body: Stack(
        children: [
          Image.asset(
            'assets/img/parrilla.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // Asegura que la imagen cubra toda la pantalla
          ),
          SafeArea( // Asegura que el contenido no se superponga con la barra de estado
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nombre del Producto'),
                  ),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Precio'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _imageUrlController,
                    decoration: InputDecoration(labelText: 'URL de Imagen'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Tipo:'),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: _selectedType,
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
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7E57C2),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _addProduct,
                    child: Text('Agregar Producto'),
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
