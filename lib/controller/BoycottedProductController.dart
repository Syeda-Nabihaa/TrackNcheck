import 'package:cloud_firestore/cloud_firestore.dart';

List<String> normalizeBrandTags(String brand) {
  // remove "brands:" prefix, lowercase, split by comma
  return brand
      .toLowerCase()
      .replaceAll("brands:", "")
      .split(",")
      .map((b) => b.trim())
      .toList();
}

Future<Map<String, dynamic>?> checkBoycottStatus(String brand) async {
  final normalized = brand.toLowerCase().trim();

  print("👉 Querying boycott DB with: '$normalized'");

  final snapshot = await FirebaseFirestore.instance
      .collection("boycotted_brands")
      .where("brand", isEqualTo: normalized)
      .limit(1)
      .get();

  print("Docs found: ${snapshot.docs.length}");

  if (snapshot.docs.isNotEmpty) {
    print("✅ Boycotted brand found: ${snapshot.docs.first.data()}");
    return snapshot.docs.first.data();
  }

  print("❌ Not boycotted");
  return null;
}
