import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Login.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/controller/ScanHistoryController.dart';

class ScanHistoryPage extends StatefulWidget {
  const ScanHistoryPage({super.key});

  @override
  State<ScanHistoryPage> createState() => _ScanHistoryPageState();
}

class _ScanHistoryPageState extends State<ScanHistoryPage> {
  final ScanHistoryController _controller = Get.put(ScanHistoryController());
    User? currentUser;

  @override
  void initState() {
    super.initState();
        currentUser = FirebaseAuth.instance.currentUser;
    _controller.fetchHistory(); // Make sure to fetch on init
  }
  Future<Map<String, dynamic>?> getUserData() async {
    if (currentUser == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser!.uid)
        .get();

    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔒 If user is not logged in
    if (currentUser == null) {
      return Scaffold(
        backgroundColor: ColorConstants.bgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
    radius: 50,
    backgroundColor: ColorConstants.fieldsColor,
    child: Icon(Icons.lock, color: Colors.white, size: 80,),
  ),
  SizedBox(height: 20,),
              Text(
                textAlign: TextAlign.center,
                "Please log in to view or store your\n scanned product history.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10,),
              TextButton(onPressed: () => Get.to(Login()), child: Text('Go to Login.', style: TextStyle(color: ColorConstants.mainColor, fontSize: 16),))
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        title: const TitleWidget(text: "Scan History", fontsize: 20),
        backgroundColor: ColorConstants.bgColor,
      ),
      body: Obx(() {
        final history = _controller.scanHistory;

        if (history.isEmpty) {
          return const Center(child: Text("No scan history yet."));
        }

        return ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];
            final timestamp = (item['timestamp'] as Timestamp?)?.toDate();
            final formattedDate = timestamp != null
                ? "${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}"
                : "Unknown";
            final isExpired = (item['result']?.toString().toLowerCase() == 'expired');
            return Card(
              color: ColorConstants.cardColor,
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.qr_code, color: Colors.white,),
                title: Text("Barcode: ${item['barcode'] ?? 'N/A'}", style: TextStyle(color: Colors.grey[200]),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Item: ${item['result'] ?? 'N/A'}",style: TextStyle(color: Colors.grey[300]),),
                     Text("Status: ${isExpired ? 'Expired' : 'Not Expired'}",
                        style: TextStyle(
                          color: isExpired ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("Scanned At: $formattedDate",style: TextStyle(color: Colors.grey[300]),),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
