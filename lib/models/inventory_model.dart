class Inventory {
  final int id;
  final int productId;
  final int availableQuantity;
  final DateTime lastUpdated;

  Inventory({
    required this.id,
    required this.productId,
    required this.availableQuantity,
    required this.lastUpdated,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      productId: json['product_id'],
      availableQuantity: json['available_quantity'],
      lastUpdated: DateTime.parse(json['last_updated']),
    );
  }
}
