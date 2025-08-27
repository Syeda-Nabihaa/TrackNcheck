// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:trackncheck/Services/ApiService.dart';
// import 'package:trackncheck/components/Button.dart';
// import 'package:trackncheck/components/TextWidgets.dart';
// import 'package:trackncheck/components/constants.dart';
// import 'package:trackncheck/components/navigationBar.dart';
// import 'package:trackncheck/controller/ScanHistoryController.dart';
// import 'package:trackncheck/model/ProductModel.dart';
// import 'package:trackncheck/scanning/Result_page.dart';

// class ProductDetailsPage extends StatefulWidget {
//   final String barcode;

//   const ProductDetailsPage({Key? key, required this.barcode}) : super(key: key);

//   @override
//   State<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   Product? product;
//   bool loading = true;

//   final scanHistoryController = Get.find<ScanHistoryController>();

//   @override
//   void initState() {
//     super.initState();
//     fetchProduct();
//   }

//   void fetchProduct() async {
//     final data = await fetchFromAllApis(widget.barcode);

//     // After you get `data`
// if (data != null && scanHistoryController.isUserLoggedIn) {
//   // try to parse expiry date safely
//   bool expired = false;
//   if (data.expirationDate != null) {
//     try {
//       final dt = DateTime.parse(data.expirationDate!);
//       expired = dt.isBefore(DateTime.now());
//     } catch (e) {
//       // ignore parse errors - set expired = false
//     }
//   }

//   final resultSummary = data.name != null
//       ? '${data.name} (${data.brand ?? ''})'
//       : 'Product scanned';

//   await scanHistoryController.saveScan(
//     barcode: widget.barcode,
//     category: 'Product Details',
//     result: resultSummary,
//     productName: data.name,
//     expiryDate: data.expirationDate,
//     isExpired: expired,
//     imageUrl: data.imageUrl,
//   );
// }

//     setState(() {
//       product = data;
//       loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (loading) return const Center(child: CircularProgressIndicator());
//     if (product == null) return const Center(child: Text("Product not found"));

//     return Scaffold(
//       appBar: AppBar(
//         title: const TitleWidget(text: "Product Details", fontsize: 20),
//         backgroundColor: ColorConstants.bgColor,
//       ),
//       backgroundColor: ColorConstants.bgColor,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (product!.imageUrl != null)
//               Center(child: Image.network(product!.imageUrl!, height: 200)),
//             const SizedBox(height: 16),
//             SubTitle(text: "Name: ${product!.name}", fontsize: 17),
//             SubTitle(text: "Brand: ${product!.brand}", fontsize: 17),
//             SubTitle(text: "Quantity: ${product!.quantity}", fontsize: 17),
//             SubTitle(text: "Ingredients: ${product!.ingredients ?? 'N/A'}", fontsize: 17),
//             SubTitle(text: "Labels: ${product!.labels ?? 'N/A'}", fontsize: 17),
//             Text("Expiry: ${product!.expirationDate ?? 'N/A'}",
//               style: const TextStyle(color: Colors.red, fontSize: 17),
//             ),
//             SubTitle(text: "Nutri-Score: ${product!.nutriScore ?? 'N/A'}", fontsize: 17),
//             SubTitle(text: "Source: ${product!.source}", fontsize: 17),
//             const SizedBox(height: 30),
//             Center(
//               child: Button(
//                 text: 'Go Back!',
//                 onPressed: () => Get.offAll(const Navigationbar()),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Services/ApiService.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/navigationBar.dart';
import 'package:trackncheck/controller/ScanHistoryController.dart';
import 'package:trackncheck/model/ProductModel.dart';

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

    if (data != null && scanHistoryController.isUserLoggedIn) {
      bool expired = false;
      if (data.expirationDate != null) {
        try {
          final dt = DateTime.parse(data.expirationDate!);
          expired = dt.isBefore(DateTime.now());
        } catch (_) {}
      }

      final resultSummary =
          data.name != null
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

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white, // changed from black87
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : "N/A",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade400,
              ), // lighter for dark bg
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: ColorConstants.bgColor,
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    if (product == null) {
      return const Scaffold(
        backgroundColor: ColorConstants.bgColor,
        body: Center(
          child: Text(
            "Product not found",
            style: TextStyle(fontSize: 18, color: Colors.redAccent),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.bgColor,
        title: const Text(
          "Product Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // changed from black87
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Product Image with shadow
            if (product!.imageUrl != null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(product!.imageUrl!),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.6,
                      ), // stronger shadow for dark theme
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // Product Name & Brand
            Text(
              product!.name ?? "Unknown Product",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (product!.brand != null)
              Text(
                product!.brand!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
              ),
            const SizedBox(height: 10),

            // Info Card (dark background card)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorConstants.cardColor, // dark grey card
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoTile("Quantity", product!.quantity ?? ""),
                  _buildInfoTile("Ingredients", product!.ingredients ?? ""),
                  _buildInfoTile("Labels", product!.labels ?? ""),
                  _buildInfoTile("Expiry", product!.expirationDate ?? "N/A"),
                  _buildInfoTile("Nutri-Score", product!.nutriScore ?? "N/A"),
                  _buildInfoTile("Source", product!.source ?? ""),
                ],
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: 450,
              child: Button(text: "Go Back!", onPressed: () {Get.offAll(Navigationbar());}),
            ),
          ],
        ),
      ),
    );
  }
}
