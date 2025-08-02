class halalChecker {
  static final List<String> haramIngredients = [
    'Lard'
    'e120',
    'e441',
    'e471',
    'alcohol',
    'ethanol',
    'l-cysteine',
    'rennet',
    'Enzymes'
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
        return true;
      }
    }

    return false;
  }
}
