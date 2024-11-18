import 'package:gf/src/modules/product/model/product_model.dart';


class Order {
  final String id;
  final List<Product> products;
  final double total;

  Order({required this.id, required this.products, required this.total});

  factory Order.fromMap(Map<String, dynamic> map) {
    var productList = map['products'] as List<dynamic>;
    List<Product> products = productList.map((item) => Product.fromMap(item)).toList();

    return Order(
      id: map['id'] ?? '',
      products: products,
      total: products.fold(0.0, (sum, item) => sum + item.price),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((product) => product.toMap()).toList(),
      'total': total,
    };
  }
}
