import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late final String id;
  final String name;
  final int quantity;
  final DateTime lastUpdated;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.lastUpdated,
  });

  Product.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        quantity = map["quantity"],
        lastUpdated = (map["lastUpdated"] as Timestamp).toDate();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "quantity": quantity,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
    };
  }
}

