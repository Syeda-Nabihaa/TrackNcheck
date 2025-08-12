import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/controller/ScanHistoryController.dart';
import 'package:trackncheck/controller/BoycottedProductController.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/Card.dart'; // Your existing result card widget

class BoycottCheckerWidget extends StatefulWidget {
  final String scannedBrand;

  const BoycottCheckerWidget({Key? key, required this.scannedBrand})
      : super(key: key);

  @override
  _BoycottCheckerWidgetState createState() => _BoycottCheckerWidgetState();
}

class _BoycottCheckerWidgetState extends State<BoycottCheckerWidget> {
  Map<String, dynamic>? boycottInfo;
  bool loading = true;

  final scanHistoryController = Get.find<ScanHistoryController>();

  @override
  void initState() {
    super.initState();
    _checkBoycott();
  }

  Future<void> _checkBoycott() async {
    final info = await checkBoycottStatus(widget.scannedBrand);


if (scanHistoryController.isUserLoggedIn) {
  final resultSummary = info != null
      ? '⚠️ Boycotted Brand - ${widget.scannedBrand}'
      : '✅ Not Boycotted - ${widget.scannedBrand}';

  await scanHistoryController.saveScan(
    barcode: widget.scannedBrand, // using brand as identifier
    category: 'Boycott Checker',
    result: resultSummary,
    productName: widget.scannedBrand,
    isExpired: false,
  );
}


    setState(() {
      boycottInfo = info;
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

    final isBoycotted = boycottInfo != null;

    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        title: const TitleWidget(text: "Boycott Checker", fontsize: 20),
        backgroundColor: ColorConstants.bgColor,
      ),
      body: Center(
        child: ResultCard(
          icon: isBoycotted ? Icons.warning : Icons.check_circle,
          iconColor: isBoycotted ? Colors.red : Colors.green,
          title: isBoycotted
              ? "⚠️ This brand is boycotted"
              : "✅ This brand is not boycotted",
          showSubtitle: isBoycotted,
          subtitle: isBoycotted ? "Brand: ${boycottInfo!['Brand']}" : "",
        ),
      ),
    );
  }
}
