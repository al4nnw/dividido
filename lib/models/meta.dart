class Meta {
  final String createdBy;
  final DateTime createdAt;

  Meta({
    required this.createdBy,
    required this.createdAt,
  });

  /// New constructor called now
  Meta.now(this.createdBy) : createdAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdBy': createdBy,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      createdBy: map['createdBy'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }
}
