class Product {
  String? name;
  String? brand;
  String? quantity;
  String? expirationDate;
  String? labels;
  String? nutriScore;
  String? ingredients;
  String? imageUrl;
  String? source;
  final Map<String, dynamic>? nutrientLevels;

  List<String>? ingredientsTags;
  List<String>? additivesTags;
  dynamic labelsTags;


  Product({
    this.name,
    this.brand,
    this.quantity,
    this.expirationDate,
    this.labels,
    this.nutriScore,
    this.ingredients,
    this.imageUrl,
    this.source,
    this.ingredientsTags,
    this.additivesTags,
    this.labelsTags,
    this.nutrientLevels,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'quantity': quantity,
      'expiration_date': expirationDate,
      'labels': labels,
      'nutri_score': nutriScore,
      'ingredients_text': ingredients,
      'image_url': imageUrl,
      'source': source,
      'ingredients_tags': ingredientsTags ?? [],
      'additives_tags': additivesTags ?? [],
      'labels_tags': labelsTags ?? [],
    };
  }
}


 