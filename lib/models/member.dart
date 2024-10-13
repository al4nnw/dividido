import 'meta.dart';

class Member {
  final String id;
  final Meta meta;

  Member({required this.id, required this.meta});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'meta': meta.toMap(),
    };
  }

  factory Member.fromMap(Map<String, dynamic> map, String id) {
    return Member(
      id: map['id'] as String,
      meta: Meta.fromMap(map['meta'] as Map<String, dynamic>),
    );
  }
}
