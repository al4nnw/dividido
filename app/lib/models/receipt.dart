import 'product.dart';

class Receipt {
  String id;
  DateTime createdAt;

  // Receipt Information
  String? storeName;
  String? address;
  String? phoneNumber;
  String? cnpj; // Optional
  String? receiptNumber;
  DateTime? dateTime;

  // Purchase Details
  List<Product>? products;

  // Summary
  num totalAmount;
  String? paymentMethod;
  num? change; // Optional
  num? tax; // Optional
  Map<String, dynamic>? otherInfo; // For any other relevant information

  Receipt(
      {required this.id,
      this.storeName,
      this.address,
      this.phoneNumber,
      this.cnpj,
      this.receiptNumber,
      this.dateTime,
      this.products,
      required this.totalAmount,
      this.paymentMethod,
      this.change,
      this.tax,
      this.otherInfo,
      required this.createdAt});

  factory Receipt.fromMap(Map<String, dynamic> map) {
    return Receipt(
      id: map['id'],
      storeName: map['storeName'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      cnpj: map['cnpj'],
      receiptNumber: map['receiptNumber'],
      dateTime: map['dateTime'] != null ? DateTime.parse(map['dateTime']) : null,
      products: map['products'] != null
          ? List<Product>.from(
              (map['products'] as List).map((x) => Product.fromMap(x as Map<String, dynamic>)))
          : null,
      totalAmount: map['totalAmount'],
      paymentMethod: map['paymentMethod'],
      change: map['change'],
      tax: map['tax'],
      otherInfo: map['otherInfo'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'totalAmount': totalAmount,
    };

    if (storeName != null) map['storeName'] = storeName;
    if (address != null) map['address'] = address;
    if (phoneNumber != null) map['phoneNumber'] = phoneNumber;
    if (cnpj != null) map['cnpj'] = cnpj;
    if (receiptNumber != null) map['receiptNumber'] = receiptNumber;
    if (dateTime != null) map['dateTime'] = dateTime?.toIso8601String();
    if (products != null) {
      map['products'] = products?.map((x) => x.toMap()).toList();
    }
    if (paymentMethod != null) map['paymentMethod'] = paymentMethod;
    if (change != null) map['change'] = change;
    if (tax != null) map['tax'] = tax;
    if (otherInfo != null) map['otherInfo'] = otherInfo;

    return map;
  }
}

Future<Receipt> getReceipt(Map<String, Object?> arguments) async {
  return Receipt(
    id: (arguments['id'] as String?) ?? "",
    storeName: arguments['storeName'] as String?,
    address: arguments['address'] as String?,
    phoneNumber: arguments['phoneNumber'] as String?,
    cnpj: arguments['cnpj'] as String?,
    receiptNumber: arguments['receiptNumber'] as String?,
    dateTime: arguments['dateTime'] != null ? DateTime.parse(arguments['dateTime'] as String) : null,
    products: arguments['products'] != null
        ? List<Product>.from(
            (arguments['products'] as List).map(
              (x) => Product.fromMap(x as Map<String, dynamic>),
            ),
          )
        : null,
    totalAmount: arguments['totalAmount'] as num,
    paymentMethod: arguments['paymentMethod'] as String?,
    change: arguments['change'] as num?,
    tax: arguments['tax'] as num?,
    otherInfo: arguments['otherInfo'] as Map<String, dynamic>?,
    createdAt: DateTime.now(),
  );
}
