import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late final String id;
  final String name;
  final double price;
  final DateTime lastUpdated;
  final List<String> itemIds;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.lastUpdated,
    required this.itemIds,
  });

  Product.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        price = map["price"],
        lastUpdated = (map["lastUpdated"] as Timestamp).toDate(),
        itemIds = List<String>.from(map["itemIds"]);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "price": price,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
      'itemsIds': itemIds,
    };
  }
}

