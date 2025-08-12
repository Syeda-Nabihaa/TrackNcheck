import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/controller/ScanHistoryController.dart';

class ScanHistoryPage extends StatefulWidget {
  const ScanHistoryPage({super.key});

  @override
  State<ScanHistoryPage> createState() => _ScanHistoryPageState();
}

class _ScanHistoryPageState extends State<ScanHistoryPage> {
  final ScanHistoryController controller = Get.find<ScanHistoryController>();
  User? currentUser;
  String selectedCategory = 'All';
  final categories = ['All', 'Product Details', 'Halal/Haram Checker', 'Boycott Checker'];

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      controller.listenToHistory(category: selectedCategory); 
    }
  }

  void _onSelectCategory(String cat) {
    setState(() {
      selectedCategory = cat;
    });
    controller.listenToHistory(category: cat); 
  }

  Color _categoryColor(String cat) {
    switch (cat) {
      case 'Product Details':
        return ColorConstants.mainColor;
      case 'Halal/Haram Checker':
        return Colors.amber;
      case 'Boycott Checker':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        backgroundColor: ColorConstants.bgColor,
        appBar: AppBar(backgroundColor: ColorConstants.bgColor),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleWidget(text: 'History', fontsize: 20),
              const SizedBox(height: 16),
              const Icon(Icons.lock, size: 60, color: Colors.white70),
              const SizedBox(height: 12),
              const Text(
                'Login to view and store your scans.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Get.toNamed('/login'),
                child: Text('Go to Login', style: TextStyle(color: ColorConstants.mainColor)),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        title: const TitleWidget(text: 'History', fontsize: 20),
        backgroundColor: ColorConstants.bgColor,
      ),
      body: Column(
        children: [
          // category chips
          SizedBox(
            height: 62,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = categories[index];
                final selected = cat == selectedCategory;
                return ChoiceChip(
                  label: Text(cat, style: TextStyle(color: selected ? Colors.black : Colors.white)),
                  selected: selected,
                  onSelected: (_) => _onSelectCategory(cat),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.grey[850],
                );
              },
            ),
          ),

          // list
          Expanded(
            child: Obx(() {
              final history = controller.scanHistory;
              if (history.isEmpty) {
                return const Center(child: Text('No scan history found.', style: TextStyle(color: Colors.white70)));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: history.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  final item = history[index];
                  final barcode = item['barcode'] ?? '';
                  final result = item['result'] ?? '';
                  final productName = item['productName'] ?? '';
                  final expiry = item['expiryDate'] ?? '';
                  final bool isExpired = (item['isExpired'] == true);
                  final Timestamp? ts = item['timestamp'] as Timestamp?;
                  final scannedAt = ts != null
                      ? DateFormat('dd MMM yyyy, hh:mm a').format(ts.toDate())
                      : 'Unknown';

                  final cat = item['category'] ?? 'Unknown';

                  return Card(
                    color: const Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isExpired ? Icons.warning_amber_rounded : Icons.check_circle,
                            color: isExpired ? Colors.red : Colors.green,
                          ),
                        ],
                      ),
                      title: Text(
                        productName.isNotEmpty ? productName : barcode,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(result, style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 6),
                          Text("Scanned: $scannedAt", style: const TextStyle(color: Colors.grey)),
                          if (expiry.isNotEmpty)
                            Text("Expiry: $expiry", style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _categoryColor(cat),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(cat, style: const TextStyle(color: Colors.black, fontSize: 11)),
                          ),
                          const SizedBox(height: 8),
                          Text(isExpired ? 'Expired' : 'OK',
                              style: TextStyle(color: isExpired ? Colors.red : Colors.green)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
