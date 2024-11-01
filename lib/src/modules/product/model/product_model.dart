import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late final String id;
  final String name;
  final DateTime lastUpdated;
  final List<String> itemsIds;

  Product({
    required this.id,
    required this.name,
    required this.lastUpdated,
    required this.itemsIds,
  });

  Product.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        lastUpdated = (map["lastUpdated"] as Timestamp).toDate(),
        itemsIds = List<String>.from(map["itemsIds"]);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
      'itemsIds': itemsIds,
    };
  }
}

