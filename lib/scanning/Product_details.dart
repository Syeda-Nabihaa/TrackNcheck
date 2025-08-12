import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Services/ApiService.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/navigationBar.dart';
import 'package:trackncheck/controller/ScanHistoryController.dart';
import 'package:trackncheck/model/ProductModel.dart';
import 'package:trackncheck/scanning/Result_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final String barcode;

  const ProductDetailsPage({Key? key, required this.barcode}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Product? product;
  bool loading = true;

  final scanHistoryController = Get.find<ScanHistoryController>(); 

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  void fetchProduct() async {
    final data = await fetchFromAllApis(widget.barcode);

    // After you get `data`
if (data != null && scanHistoryController.isUserLoggedIn) {
  // try to parse expiry date safely
  bool expired = false;
  if (data.expirationDate != null) {
    try {
      final dt = DateTime.parse(data.expirationDate!);
      expired = dt.isBefore(DateTime.now());
    } catch (e) {
      // ignore parse errors - set expired = false
    }
  }

  final resultSummary = data.name != null
      ? '${data.name} (${data.brand ?? ''})'
      : 'Product scanned';

  await scanHistoryController.saveScan(
    barcode: widget.barcode,
    category: 'Product Details',
    result: resultSummary,
    productName: data.name,
    expiryDate: data.expirationDate,
    isExpired: expired,
    imageUrl: data.imageUrl,
  );
}


    setState(() {
      product = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (product == null) return const Center(child: Text("Product not found"));

    return Scaffold(
      appBar: AppBar(
        title: const TitleWidget(text: "Product Details", fontsize: 20),
        backgroundColor: ColorConstants.bgColor,
      ),
      backgroundColor: ColorConstants.bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product!.imageUrl != null)
              Center(child: Image.network(product!.imageUrl!, height: 200)),
            const SizedBox(height: 16),
            SubTitle(text: "Name: ${product!.name}", fontsize: 17),
            SubTitle(text: "Brand: ${product!.brand}", fontsize: 17),
            SubTitle(text: "Quantity: ${product!.quantity}", fontsize: 17),
            SubTitle(text: "Ingredients: ${product!.ingredients ?? 'N/A'}", fontsize: 17),
            SubTitle(text: "Labels: ${product!.labels ?? 'N/A'}", fontsize: 17),
            Text("Expiry: ${product!.expirationDate ?? 'N/A'}",
              style: const TextStyle(color: Colors.red, fontSize: 17),
            ),
            SubTitle(text: "Nutri-Score: ${product!.nutriScore ?? 'N/A'}", fontsize: 17),
            SubTitle(text: "Source: ${product!.source}", fontsize: 17),
            const SizedBox(height: 30),
            Center(
              child: Button(
                text: 'Go Back!',
                onPressed: () => Get.offAll(const Navigationbar()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
