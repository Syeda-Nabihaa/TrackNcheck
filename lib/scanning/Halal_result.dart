import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Services/ApiService.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/navigationBar.dart';
import 'package:trackncheck/controller/ScanHistoryController.dart';
import 'package:trackncheck/model/ProductModel.dart';
import 'package:trackncheck/scanning/Halal_checker.dart';

class HalalResultPage extends StatefulWidget {
  final String barcode;

  const HalalResultPage({Key? key, required this.barcode}) : super(key: key);

  @override
  State<HalalResultPage> createState() => _HalalResultPageState();
}

class _HalalResultPageState extends State<HalalResultPage>
    with SingleTickerProviderStateMixin {
  Product? product;
  bool loading = true;

  final scanHistoryController = Get.find<ScanHistoryController>();

  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    fetchProduct();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fetchProduct() async {
    final data = await fetchFromAllApis(widget.barcode);

    if (data != null && scanHistoryController.isUserLoggedIn) {
      final isHaram = halalChecker.isProductHaram(data.toMap());
      final resultSummary =
          isHaram
              ? '⚠️ Possibly Haram - ${data.name ?? 'Unknown'}'
              : '✅ Appears Halal - ${data.name ?? 'Unknown'}';

      await scanHistoryController.saveScan(
        barcode: widget.barcode,
        category: 'Halal/Haram Checker',
        result: resultSummary,
        productName: data.name,
        expiryDate: data.expirationDate,
        isExpired: false,
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
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    if (product == null) {
      return const Scaffold(
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
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const TitleWidget(text: "Halal/Haram Checker", fontsize: 20),
        ),
        backgroundColor: ColorConstants.bgColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    // colors: isHaram
                    //     ? [Colors.red.shade900, Colors.redAccent.shade200]
                    //     : [Colors.green.shade700, Colors.greenAccent.shade200],
                    colors:
                        isHaram
                            ? [
                              ColorConstants.fieldsColor,
                              ColorConstants.cardColor,
                            ]
                            : [
                              ColorConstants.fieldsColor,
                              ColorConstants.cardColor,
                            ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          isHaram
                              ? Colors.red.withOpacity(0.3)
                              : Colors.green.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: Icon(
                        isHaram
                            ? Icons.warning_amber_rounded
                            : Icons.check_circle,
                        size: 80,
                        color: isHaram ? Colors.red : Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isHaram
                          ? "⚠️ This product may be Haram"
                          : "✅ This product appears Halal",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Product: ${product!.name ?? 'Unknown'}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    if (isCertifiedHalal)
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "✔️ Halal certification or label detected",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => Get.offAll(Navigationbar()),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Go Back"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:
                            isHaram
                                ? Colors.red.shade700
                                : Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
