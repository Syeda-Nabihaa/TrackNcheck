class Product {
  final String name;
  final String brand;
  final String quantity;
  final String? imageUrl;
  final String? labels;
  final String? expirationDate;
  final String? nutriScore;
  final String? ingredients;
  final Map<String, dynamic>? nutrientLevels;
  final String source;

  Product({
    required this.name,
    required this.brand,
    required this.quantity,
    this.imageUrl,
    this.labels,
    this.expirationDate,
    this.nutriScore,
    this.ingredients,
    this.nutrientLevels,
    required this.source,
  });
}
