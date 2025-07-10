import 'package:flutter/material.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';

class ScanHistoryPage extends StatelessWidget {
  const ScanHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TitleWidget(text: 'History',fontsize: 20,),
          SizedBox(height: 15,),
          ScanHistoryItem(
            name: "Dettol Handwash",
            scanDate: "July 9, 2025",
            expiry: "Aug 15, 2025",
            status: "Safe",
            statusColor: Colors.green,
          ),
          Divider(color: Colors.grey),
          ScanHistoryItem(
            name: "Oreo Biscuits",
            scanDate: "July 7, 2025",
            expiry: "July 5, 2025",
            status: "Expired",
            statusColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class ScanHistoryItem extends StatelessWidget {
  final String name, scanDate, expiry, status;
  final Color statusColor;

  const ScanHistoryItem({
    super.key,
    required this.name,
    required this.scanDate,
    required this.expiry,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("📦 $name", style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 4),
        Text("Scanned: $scanDate", style: TextStyle(color: Colors.grey[400])),
        Text("Expiry: $expiry", style: TextStyle(color: Colors.grey[400])),
        Text("Status: $status", style: TextStyle(color: statusColor)),
        const SizedBox(height: 12),
      ],
    );
  }
}
