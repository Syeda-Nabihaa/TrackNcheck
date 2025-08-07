import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Services/ApiService.dart';
import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/Card.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/model/ProductModel.dart';
import 'package:trackncheck/scanning/Halal_result.dart';
import 'package:trackncheck/scanning/Product_details.dart';
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

  void _navigate(BuildContext context, bool isHalalCheck) async {
    final result = await Get.to(() => const ScanPage());
    if (result != null) {
      if (isHalalCheck) {
        Get.to(() => HalalResultPage(barcode: result));
      } else {
        Get.to(() => ProductDetailsPage(barcode: result));
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
            SizedBox(height: 30,),
            SizedBox(
              width: 450,
              child: TitleWidget(
                text: "Scan Your Product and Get the Result Instantly",
                fontsize: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardWidget(
                    title: "📦 Product Details",
                    description: "Scan to view full product information",
                    onTap: () => _navigate(context, false),
                  ),
                  const SizedBox(height: 24),
                  CardWidget(
                    title: "🕌 Halal/Haram Checker",
                    description: "Scan to check if product is Halal",
                    onTap: () => _navigate(context, true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
