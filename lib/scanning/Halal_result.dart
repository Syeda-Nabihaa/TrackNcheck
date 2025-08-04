import 'package:flutter/material.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/scanning/Halal_checker.dart';

class HalalResult extends StatelessWidget {
  final Map<String, dynamic> productData;

  const HalalResult({Key? key, required this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isHaram = halalChecker.isProductHaram(productData);

    // Lowercased ingredients_text for checking 'halal' keyword
    final String ingredients = productData['ingredients_text']?.toLowerCase() ?? '';

    // Read labels_tags safely
    final dynamic labelsRaw = productData['labels_tags'];

    // True if halal keyword found in labels or ingredients_text
    final bool isCertifiedHalal =
        (labelsRaw is List && labelsRaw.any((l) => l.toLowerCase().contains('halal'))) ||
        labelsRaw.toString().toLowerCase().contains('halal') ||
        ingredients.contains('halal');

    return Center(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isHaram ? Icons.warning : Icons.check_circle,
                color: isHaram ? Colors.red : Colors.green,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                isHaram
                    ? "⚠️ This product may be Haram"
                    : "✅ This product appears to be Halal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isHaram ? Colors.red : Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              if (isCertifiedHalal)
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    "✔️ Halal certification or label detected",
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}
