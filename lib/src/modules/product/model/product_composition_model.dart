class ProductComposition {
  final int id;
  final int finalProductId;
  final int ingredientProductId;
  final int requiredQuantity;
  //mudar o nome das váriaveis de acordo com oq vai vir da API(pra fazer a composição do produto)

  ProductComposition({
    required this.id,
    required this.finalProductId,
    required this.ingredientProductId,
    required this.requiredQuantity,
  });

  factory ProductComposition.fromJson(Map<String, dynamic> json) {
    return ProductComposition(
      id: json['id'],
      finalProductId: json['final_product_id'],
      ingredientProductId: json['ingredient_product_id'],
      requiredQuantity: json['required_quantity'],
    );
  }
}
