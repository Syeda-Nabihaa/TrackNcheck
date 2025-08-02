import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Services/ApiService.dart';
import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/model/ProductModel.dart';
import 'package:trackncheck/scanning/Halal_result.dart';
import 'package:trackncheck/scanning/Scan_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String? _scannedResult;
  Product? productDetails;
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
        final data = await fetchFromAllApis(result);
        setState(() {
          if (data != null) {
            productDetails = data;
          } else {
            Get.dialog(
              AlertWidget(
                message: "Product not found",
                subtext: 'It only scans barcodes included in supported APIs',
                animation: "assets/animations/error.json",
              ),
            );
            // error = 'Product not found in integrste apis';
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

                          if (productDetails!.imageUrl != null)
                            Center(
                              child: Image.network(
                                productDetails!.imageUrl!,
                                width: 200,
                                height: 200,
                              ),
                            ),
                          SubTitle(text: '• Name: ${productDetails!.name}'),
                          SubTitle(text: '• Brand: ${productDetails!.brand}'),
                          SubTitle(
                            text: '• Quantity: ${productDetails!.quantity}',
                          ),
                          Text(
                            '• Expiry: ${productDetails!.expirationDate ?? 'Not provided'}',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              letterSpacing: 2.0,
                            ),
                          ),
                          SubTitle(
                            text:
                                '• Labels: ${productDetails!.labels ?? 'N/A'}',
                          ),
                          Text(
                            '• Expiry: ${productDetails!.expirationDate ?? 'Not provided'}',
                          ),
                          SubTitle(
                            text:
                                '• Nutri-Score: ${productDetails!.nutriScore ?? 'N/A'}',
                          ),
                          SubTitle(
                            text:
                                '• Ingredients: ${productDetails!.ingredients ?? 'N/A'}',
                          ),
                          SubTitle(text: '• Source: ${productDetails!.source}'),

                          const SizedBox(height: 20),
                          // HalalResult(productData: productDetails!),
                          // const SizedBox(height: 20),
                        ],

                        if (_scannedResult != null) ...[
                          Center(
                            child: Text(
                              'Barcode: $_scannedResult',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
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
