import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trackncheck/model/ProductModel.dart';

//--------------------------------OPEN FOOD FACTS----------------------------------------------
Future<Product?> fetchFromOpenFoodFacts(String barcode) async {
  final url =
      'https://world.openfoodfacts.org/api/v0/product/$barcode.json?lc=en';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == 1) {
      final product = data['product'];
      return Product(
        name: product['product_name'] ?? 'N/A',
        brand: product['brands'] ?? 'N/A',
        quantity: product['quantity'] ?? 'N/A',
        imageUrl: product['image_url'],
        labels: product['labels'],
        expirationDate: product['expiration_date'],
        nutriScore: product['nutriscore_grade'],
        ingredients: product['ingredients_text'],
        nutrientLevels: product['nutrient_levels'],
        source: 'Open Food Facts',
      );
    }
  }
  return null;
}

// -------------------------------OPEN BEAUTY FACTS API-------------------------------------
Future<Product?> fetchFromOpenBeautyFacts(String barcode) async {
  final url =
      'https://world.openbeautyfacts.org/api/v0/product/$barcode.json?lc=en';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == 1) {
      final product = data['product'];
      return Product(
        name: product['product_name'] ?? 'N/A',
        brand: product['brands'] ?? 'N/A',
        quantity: product['quantity'] ?? 'N/A',
        imageUrl: product['image_url'],
        labels: product['labels'],
        expirationDate: product['expiration_date'],
        nutriScore: null,
        ingredients: product['ingredients_text'],
        nutrientLevels: null,
        source: 'Open Beauty Facts',
      );
    }
  }
  return null;
}

// -------------------------------OPEN PET FOOD FACTS API-------------------------------------
Future<Product?> fetchFromOpenPetFoodFacts(String barcode) async {
    final url = 'https://world.openpetfoodfacts.org/api/v0/product/$barcode.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == 1 && data['product'] != null) {
      final product = data['product'];
      return Product(
        name: product['product_name'] ?? 'N/A',
        brand: product['brands'] ?? 'N/A',
        quantity: product['quantity'] ?? 'N/A',
        imageUrl: product['image_url'],
        labels: product['labels'],
        expirationDate: product['expiration_date'],
        nutriScore: product['nutriscore_grade'],
        ingredients: product['ingredients_text'],
        nutrientLevels: product['nutrient_levels'],
        source: 'Open Pet Food Facts',
      );
    }
  }
  return null;
}


Future<Product?> fetchFromAllApis(String barcode) async {
  try {
    final results = await Future.wait([
      _safeFetch(() => fetchFromOpenFoodFacts(barcode), "OpenFoodFacts"),
      _safeFetch(() => fetchFromOpenBeautyFacts(barcode), "OpenBeautyFacts"),
        _safeFetch(() => fetchFromOpenPetFoodFacts(barcode), "OpenPetFoodFacts")
      // Add more fetchers here
    ]);

    for (final result in results) {
      if (result != null) return result;
    }

    return null;
  } catch (e, stack) {
    print("Unexpected error in fetchFromAllApis: $e");
    print(stack);
    return null;
  }
}

Future<Product?> _safeFetch(
  Future<Product?> Function() fetcher,
  String source,
) async {
  try {
    return await fetcher();
  } catch (e) {
    print("Error fetching from $source: $e");
    return null;
  }
}
