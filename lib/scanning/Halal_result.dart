import 'package:flutter/material.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/scanning/Halal_checker.dart';

class HalalResult extends StatelessWidget {
  final Map<String, dynamic> productData;

  const HalalResult({Key? key, required this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isHaram = halalChecker.isProductHaram(productData);

    // Fix: Handle labels_tags being List or String
    final dynamic labelsRaw = productData['labels_tags'];
    final bool isCertifiedHalal =
        (labelsRaw is List)
            ? labelsRaw.contains('halal')
            : labelsRaw.toString().toLowerCase().contains('halal');

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
                    "✔️ Certified Halal label found",
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
