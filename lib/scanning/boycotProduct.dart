import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/controller/ScanHistoryController.dart';
import 'package:trackncheck/controller/BoycottedProductController.dart';
import 'package:trackncheck/components/constants.dart';

class BoycottCheckerWidget extends StatefulWidget {
  final String scannedBrand;

  const BoycottCheckerWidget({Key? key, required this.scannedBrand})
      : super(key: key);

  @override
  _BoycottCheckerWidgetState createState() => _BoycottCheckerWidgetState();
}

class _BoycottCheckerWidgetState extends State<BoycottCheckerWidget>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? boycottInfo;
  bool loading = true;

  final scanHistoryController = Get.find<ScanHistoryController>();

  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _checkBoycott();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkBoycott() async {
    final info = await checkBoycottStatus(widget.scannedBrand);

    if (scanHistoryController.isUserLoggedIn) {
      final resultSummary = info != null
          ? '⚠️ Boycotted Brand - ${widget.scannedBrand}'
          : '✅ Not Boycotted - ${widget.scannedBrand}';

      await scanHistoryController.saveScan(
        barcode: widget.scannedBrand,
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
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final isBoycotted = boycottInfo != null;

    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        title: const TitleWidget(text: "Boycott Checker", fontsize: 20),
        backgroundColor: ColorConstants.bgColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: isBoycotted
                        ? [Colors.red.shade900, Colors.redAccent.shade200]
                        : [Colors.green.shade700, Colors.greenAccent.shade200],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isBoycotted
                          ? Colors.red.withOpacity(0.4)
                          : Colors.green.withOpacity(0.4),
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
                        isBoycotted ? Icons.warning_amber_rounded : Icons.check_circle,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isBoycotted
                          ? "⚠️ This brand is boycotted"
                          : "✅ This brand is not boycotted",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Brand: ${widget.scannedBrand}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    if (isBoycotted)
                    ElevatedButton.icon(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Go Back"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: isBoycotted ? Colors.red : Colors.green,
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
