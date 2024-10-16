import 'expense.dart';
import 'member.dart';
import 'meta.dart';

class Group {
  final String id;
  final String? description;
  final String? imageUrl;
  final String name;
  final Meta meta;

  Group({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.meta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'meta': meta.toMap(),
    };
  }

  factory Group.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Group(
      id: id,
      name: map['name'] as String,
      description: map['description'] as String?,
      imageUrl: map['imageUrl'] as String?,
      meta: Meta.fromMap(map['meta'] as Map<String, dynamic>),
    );
  }
}
