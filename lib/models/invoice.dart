
import 'package:backup/models/product.dart';

class Invoice {
  final List<Product> items; // Lista con productos
  final double subtotal;
  final double discount;
  final double total;

  Invoice({
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.total,
  });

}

