import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class MenuController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para guardar un producto en Firebase
  Future<void> addProduct(Product product) async {
    try {
      await _firestore.collection('products').add(product.toMap());
    } catch (e) {
      throw Exception('Error al agregar producto: $e');
    }
  }

  // Método para eliminar un producto por su nombre
  Future<void> deleteProductByName(String name) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('name', isEqualTo: name)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Error al eliminar producto: $e');
    }
  }

  // Método para obtener todos los productos
  Future<List<Product>> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Error al obtener productos: $e');
    }
  }
/** 
  Future<List<Product>> fetchProductsByType(String type) async {
  try {
    final snapshot = await _firestore
        .collection('products')
        .where('type', isEqualTo: type)
        .get();
    return snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
  } catch (e) {
    throw Exception('Error al obtener productos de tipo $type: $e');
  }
}*/
  Future<List<Product>> fetchProductsByType(String type) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('type', isEqualTo: type)
          .get();

      return snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Error al obtener productos: $e');
    }
  }



}

final menuController = MenuController();
