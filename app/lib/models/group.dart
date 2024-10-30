import 'meta.dart';

class Group {
  final String id;
  List<String> memberIds = [];
  final String? description;
  final String? imageUrl;
  final String ownerId;
  final String ownerName;
  final String name;
  final Meta meta;

  Group({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.ownerName,
    this.description,
    this.imageUrl,
    this.memberIds = const [],
    required this.meta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'memberIds': memberIds,
      'ownerId': ownerId,
      'ownerName': ownerName,
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
      ownerId: (map['ownerId'] ?? "") as String,
      ownerName: (map['ownerName'] ?? "") as String,
      description: map['description'] as String?,
      imageUrl: map['imageUrl'] as String?,
      memberIds: (map['memberIds'] as List<dynamic>).map((e) => e as String).toList(),
      meta: Meta.fromMap(map['meta'] as Map<String, dynamic>),
    );
  }
}
