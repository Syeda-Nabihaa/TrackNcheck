import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AiBarcodeScanner(
        galleryButtonType: GalleryButtonType.icon,
        onDetect: (capture) {
          final code = capture.barcodes.firstOrNull?.rawValue;
          if (code != null) {
            Navigator.pop(context, code);
          }
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class ScanPage extends StatelessWidget {
//   const ScanPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MobileScanner(
//         onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           for(final barcode in barcodes){
//             debugPrint('Barcode found! ${barcode.rawValue}');
//           }
//         },
//       ),
//     );
//   }
// }
