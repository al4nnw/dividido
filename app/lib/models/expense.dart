import 'receipt.dart';
import 'block.dart';
import 'meta.dart';

class Expense {
  final String id;
  final Meta meta;
  final String name;
  final num value;
  final Receipt? receipt;
  final List<Block> distributionList;

  Expense({
    required this.id,
    required this.meta,
    required this.name,
    required this.value,
    required this.distributionList,
    this.receipt,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'meta': meta.toMap(),
      'name': name,
      'value': value,
      'distributionList': distributionList.map((x) => x.toMap()).toList(),
    };

    if (receipt != null) map['receipt'] = receipt?.toMap();

    return map;
  }

  factory Expense.fromMap(String id, Map<String, dynamic> map) {
    return Expense(
      id: id,
      meta: Meta.fromMap(map['meta'] as Map<String, dynamic>),
      name: map['name'] as String,
      value: map['value'] as num,
      distributionList: List<Block>.from(
        (map['distributionList'] as List<int>).map<Block>(
          (x) => Block.fromMap(x as Map<String, dynamic>),
        ),
      ),
      receipt: map['receipt'] == null ? null : Receipt.fromMap(map['receipt'] as Map<String, dynamic>),
    );
  }
}
