import 'package:uuid/uuid.dart';

class Product {
  final String id;
  String? name;
  int? quantity;
  num? price;
  Product? originalProduct;

  Product({
    required this.id,
    this.name,
    this.quantity,
    this.price,
    this.originalProduct,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: const Uuid().v4(),
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      if (name != null) 'name': name,
      if (quantity != null) 'quantity': quantity,
      if (price != null) 'price': price,
    };
  }
}
