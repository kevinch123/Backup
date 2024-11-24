
class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String type;
  int quantity;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.type,
    this.quantity = 1,
  });

  // Método para convertir un producto a un mapa para Firebase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'type': type,
      'quantity': quantity,
    };
  }

  // Método para crear un producto desde un mapa de Firebase
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      type: map['type'],
      quantity: map['quantity'] ?? 1,
    );
  }
}
