import 'package:flutter/material.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleWidget(text: 'Privacy Policy', fontsize: 20,),
              SizedBox(height: 15,),
              const Text(
                '''
TrackNCheck is committed to protecting your privacy. This app does not collect, store, or share any personal information without your permission.

Data Usage:
The app only uses barcode data to determine product expiry information. No personal or product data is stored on our servers.

Permissions:
TrackNCheck may request camera access to scan barcodes. This is only used for scanning and is never shared.

Third-Party Services:
TrackNCheck does not integrate with or share data with any third-party service providers.

Changes:
Any future updates to this policy will be reflected within the app.

Contact:
For questions, email us at support@trackncheck.app
            ''',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
