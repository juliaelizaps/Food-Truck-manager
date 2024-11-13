import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String comment;
  final List<Map<String, dynamic>> products;
  final double total;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.comment,
    required this.products,
    required this.total,
    required this.createdAt,
  });

  Order.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        comment = map["comment"],
        products = List<Map<String, dynamic>>.from(map["products"]),
        total = map["total"],
        createdAt = (map["createdAt"] as Timestamp).toDate();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "comment": comment,
      "products": products,
      "total": total,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

//drawer:const SideBar(),