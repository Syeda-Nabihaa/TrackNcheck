class halalChecker {
  static final List<String> haramIngredients = [
    'lard',
    'e120',
    'e441',
    'e471',
    'alcohol',
    'ethanol',
    'l-cysteine',
    'rennet',
    'enzymes',
    'gelatin',
    'Beers'
  ];

  static bool isProductHaram(Map<String, dynamic> productData) {
    final ingredientsText =
        productData['ingredients_text']?.toLowerCase() ?? '';

    final tags = [
      ...(productData['ingredients_tags'] ?? []),
      ...(productData['additives_tags'] ?? []),
    ];

    for (var keyword in haramIngredients) {
      if (ingredientsText.contains(keyword) ||
          tags.any((tag) => tag.toString().toLowerCase().contains(keyword))) {
        print('HARAM KEYWORD matched: $keyword');
        return true;
      }
    }

    return false;
  }
}
