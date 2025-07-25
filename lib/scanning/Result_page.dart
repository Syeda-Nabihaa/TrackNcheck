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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await Get.to(ScanPage());
            if (result != null) {
              SizedBox(child: Text(result));
              print('Scanned : $result');
            }
          },
          child: Text('Scanned barcode'),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:trackncheck/scanning/Scan_page.dart';

// class ResultPage extends StatefulWidget {
//   const ResultPage({super.key});

//   @override
//   State<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends State<ResultPage> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Get.to(ScanPage());
//       },
//       child: Text("scan barcode"),
//     );
//   }
// }
