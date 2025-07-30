import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool _hasScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Barcode')),
      body: MobileScanner(
       
        controller: MobileScannerController(),
        onDetect: (BarcodeCapture capture) {
          if (_hasScanned) return;
          final barcode = capture.barcodes.first;
          final String? code = barcode.rawValue;

          if (code != null) {
            _hasScanned = true;
            Navigator.pop(context, code); // Return scanned code to ResultPage
          }
        },
      ),
    );
  }
}
