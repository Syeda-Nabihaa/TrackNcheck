import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Services/ApiService.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/scanning/Scan_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String? _scannedResult;
  Map<String, dynamic>? productDetails;
  bool loading = false;
  String? error;

  void scanAndFetch() async {
    final result = await Get.to(() => const ScanPage());
    if (result != null) {
      setState(() {
        _scannedResult = result;
        loading = true;
        productDetails = null;
        error = null;
      });
      try {
        final data = await fetchProductDetails(result);
        setState(() {
          if (data != null) {
            productDetails = data;
          } else {
            error = 'Product not found in OpenFoodFacts.';
          }
        });
      } catch (e) {
        setState(() {
          error = 'Error fetching product data.';
        });
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (loading) ...[
                          const Center(child: CircularProgressIndicator()),
                          const SizedBox(height: 20),
                        ],

                        if (error != null) ...[
                          Text(
                            error!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                        ],

                        if (productDetails != null) ...[
                          TitleWidget(text: "Product Details", fontsize: 30),
                          const SizedBox(height: 12),
                          if (productDetails!['image_url'] != null)
                            Center(
                              child: Image.network(
                                productDetails!['image_url'],
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),

                          const SizedBox(height: 12),
                          SubTitle(
                            text:
                                '• Name: ${productDetails!['product_name'] ?? 'N/A'}',
                          ),

                          SubTitle(
                            text:
                                '• Brand: ${productDetails!['brands'] ?? 'N/A'}',
                          ),

                          SubTitle(
                            text:
                                '• Quantity: ${productDetails!['quantity'] ?? 'N/A'}',
                          ),
                          SubTitle(
                            text:
                                '• Label:${productDetails!['labels'] ?? 'N/A'}',
                          ),

                          Text(
                            '• Expiry: ${productDetails!['expiration_date'] ?? 'Not provided'}',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TitleWidget(
                            text: "Ingredients & Nutrition:",
                            fontsize: 20,
                          ),
                          SubTitle(
                            text:
                                '• Nutri-Score: ${productDetails!['nutriscore_grade']?.toUpperCase() ?? 'N/A'}',
                          ),
                          SubTitle(
                            text:
                                '• Nutrient_levels: ${productDetails!['nutrient_levels'] ?? 'N/A'}',
                          ),
                          

                          const SizedBox(height: 20),
                        ],

                        if (_scannedResult != null) ...[
                          Text(
                            'Barcode: $_scannedResult',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Scan Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SizedBox(
                width: 300,

                child: Button(text: "Scan Barcode", onPressed: scanAndFetch),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
