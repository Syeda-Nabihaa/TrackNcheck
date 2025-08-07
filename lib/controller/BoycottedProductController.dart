import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> checkBoycottStatus(String brand) async {
  final normalizedBrand = brand.toLowerCase().trim();
    

  final query = await FirebaseFirestore.instance
      .collection('boycotted_brands')
      .where('brand', isEqualTo: normalizedBrand)
      .limit(1)
      .get();

  if (query.docs.isNotEmpty) {
    return query.docs.first.data();
  }

  return null;
}
