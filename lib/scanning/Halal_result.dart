import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Services/ApiService.dart';
import 'package:trackncheck/components/Card.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/controller/ScanHistoryController.dart';
import 'package:trackncheck/model/ProductModel.dart';
import 'package:trackncheck/scanning/Halal_checker.dart';

class HalalResultPage extends StatefulWidget {
  final String barcode;

  const HalalResultPage({Key? key, required this.barcode}) : super(key: key);

  @override
  State<HalalResultPage> createState() => _HalalResultPageState();
}

class _HalalResultPageState extends State<HalalResultPage> {
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
  final isHaram = halalChecker.isProductHaram(data.toMap());
  final resultSummary = isHaram
      ? '⚠️ Possibly Haram - ${data.name ?? 'Unknown'}'
      : '✅ Appears Halal - ${data.name ?? 'Unknown'}';

  await scanHistoryController.saveScan(
    barcode: widget.barcode,
    category: 'Halal/Haram Checker',
    result: resultSummary,
    productName: data.name,
    expiryDate: data.expirationDate,
    isExpired: false, // halal check is not about expiry; set false or omit
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
    if (loading) {
      return const Scaffold(
        backgroundColor: ColorConstants.bgColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (product == null) {
      return const Scaffold(
        backgroundColor: ColorConstants.bgColor,
        body: Center(
          child: Text(
            "Product not found",
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    final isHaram = halalChecker.isProductHaram(product!.toMap());
    final ingredients = product!.ingredients?.toLowerCase() ?? '';
    final labelsRaw = product!.labels?.toLowerCase() ?? '';

    final isCertifiedHalal =
        labelsRaw.contains("halal") || ingredients.contains("halal");

    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        title: const TitleWidget(text: "Halal/Haram Checker", fontsize: 20),
        backgroundColor: ColorConstants.bgColor,
      ),
      body: Center(
        child: ResultCard(
          icon: isHaram ? Icons.warning : Icons.check_circle,
          iconColor: isHaram ? Colors.red : Colors.green,
          title: isHaram
              ? " This product may be Haram \n  Product : ${product!.name ?? 'Unknown Product'}"
              : " This product appears to be Halal",
          showSubtitle: isCertifiedHalal,
          subtitle: "✔️ Halal certification or label detected",
        ),
        
      ),
    );
  }
}
