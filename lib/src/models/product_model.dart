class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String type;
  //adicionar a foto do lanche também aqui(para pagina de produtos)

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      type: json['type'],
    );
  }
}
