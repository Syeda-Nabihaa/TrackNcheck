import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/scanning/Scan_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String? _scannedResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await Get.to(ScanPage());
                  if (result != null) {
                    setState(() {
                      _scannedResult = result;
                    });
                    print("Scanned :$result");
                    Get.snackbar("Scan Complete", "Result: $result");
                  }
                },
                child: Text('Scanned barcode'),
              ),
              SizedBox(height: 20),
              if (_scannedResult != null)
                Text(
                  'Scanned Data:\n$_scannedResult',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
