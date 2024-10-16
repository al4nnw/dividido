import 'product.dart';

class Block {
  String name;
  final String id;
  final List<Product> products;

  Block({
    required this.name,
    List<Product>? products,
    required this.id,
  }) : products = products ?? [];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Block.fromMap(Map<String, dynamic> map) {
    return Block(
      name: map['name'] as String,
      id: map['id'] as String,
      products: List<Product>.from(
        (map['products'] as List<int>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
