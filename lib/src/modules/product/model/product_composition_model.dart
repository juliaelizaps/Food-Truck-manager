class ProductComposition {

  ///código abaixo é de exemplo, muda pra funcionar
  ///
  final int id;
  final int name;
  final int availableQuantity;
  final DateTime lastUpdated;

  ProductComposition({
    required this.id,
    required this.name,
    required this.availableQuantity,
    required this.lastUpdated,
  });

  ProductComposition.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        availableQuantity = map["availableQuantity"],
        lastUpdated = map["lastUpdated"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productId": name,
      "availableQuantity": availableQuantity,
      "lastUpdated": lastUpdated,
    };
  }
}
