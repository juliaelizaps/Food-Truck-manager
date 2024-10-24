class Product {

  ///código abaixo é de exemplo, muda pra funcionar
  ///
  final int id;
  final int productId;
  final int availableQuantity;
  final DateTime lastUpdated;

  Product({
    required this.id,
    required this.productId,
    required this.availableQuantity,
    required this.lastUpdated,
  });

  Product.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        productId = map["productId"],
        availableQuantity = map["availableQuantity"],
        lastUpdated = map["lastUpdated"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productId": productId,
      "availableQuantity": availableQuantity,
      "lastUpdated": lastUpdated,
    };
  }
}
