import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String comment;
  final List<OrderProduct> products;
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
        products = (map["products"] as List)
            .map((product) => OrderProduct.fromMap(product))
            .toList(),
        total = map["total"],
        createdAt = (map["createdAt"] as Timestamp).toDate();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "comment": comment,
      "products": products.map((product) => product.toMap()).toList(),
      "total": total,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

class OrderProduct {
  final String id;
  final String name;
  final double price;

  OrderProduct({
    required this.id,
    required this.name,
    required this.price,
  });

  OrderProduct.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        price = map["price"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "price": price,
    };
  }
}