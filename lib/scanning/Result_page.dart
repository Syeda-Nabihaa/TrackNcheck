import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Services/ApiService.dart';
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: scanAndFetch,
                child: const Text('Scan Barcode'),
              ),
              const SizedBox(height: 20),
              if (loading) const CircularProgressIndicator(),
              if (error != null)
                Text(error!, style: const TextStyle(color: Colors.red)),
              if (productDetails != null) ...[
                Text('Name: ${productDetails!['product_name'] ?? 'N/A'}'),
                Text('Brand: ${productDetails!['brands'] ?? 'N/A'}'),
                Text('Quantity: ${productDetails!['quantity'] ?? 'N/A'}'),
                Text(
                  'Expiry: ${productDetails!['expiration_date'] ?? 'Not provided'}',
                ),
                Text(
                  'Manufactured in: ${productDetails!['manufacturing_places'] ?? 'N/A'}',
                ),
              ],
              const SizedBox(height: 20),
              if (_scannedResult != null)
                Text(
                  'Barcode: $_scannedResult',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
