import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackncheck/SetExpiry.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  Stream<QuerySnapshot<Map<String, dynamic>>> _remindersStream(String uid) {
  return FirebaseFirestore.instance
      .collection('expiry_reminders')
      .doc(uid)
      .collection('items')
      .orderBy('expiryDate')
      .snapshots();
}


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: ColorConstants.bgColor,
        appBar: AppBar(backgroundColor: ColorConstants.bgColor),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleWidget(text: 'Reminders', fontsize: 20),
              const SizedBox(height: 16),
              const Icon(Icons.lock, size: 60, color: Colors.white70),
              const SizedBox(height: 12),
              const Text(
                'Login to view and manage your reminders.',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text('Go to Login',
                    style: TextStyle(color: ColorConstants.mainColor)),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const TitleWidget(text: 'Reminders', fontsize: 20),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _remindersStream(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No reminders yet.",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Setexpiry()),
                      );
                    },
                    child: Text('Add your first reminder',
                        style:
                            TextStyle(color: ColorConstants.mainColor)),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            separatorBuilder: (_, __) => const Divider(color: Colors.grey),
            itemBuilder: (context, index) {
              final data = docs[index].data();
              final productName = data['productName']?.toString() ?? 'N/A';
              final ts = data['expiryDate'] as Timestamp?;
              final expiry = ts?.toDate();
              final createdTs = data['createdAt'] as Timestamp?;
              final created = createdTs?.toDate();

              String expiryStr =
                  expiry != null ? DateFormat('dd MMM yyyy').format(expiry) : 'N/A';
              String createdStr =
                  created != null ? DateFormat('dd MMM yyyy').format(created) : 'N/A';

              // days left & status color
              int? daysLeft =
                  expiry != null ? expiry.difference(DateTime.now()).inDays : null;
              Color statusColor;
              String statusText;
              if (daysLeft == null) {
                statusText = 'Unknown';
                statusColor = Colors.grey;
              } else if (daysLeft < 0) {
                statusText = 'Expired';
                statusColor = Colors.red;
              } else if (daysLeft <= 3) {
                statusText = 'Expiring Soon';
                statusColor = Colors.amber;
              } else {
                statusText = 'OK';
                statusColor = Colors.green;
              }

              return Card(
                color: const Color(0xFF1E1E1E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  leading: Icon(
                    statusText == 'Expired'
                        ? Icons.warning_amber_rounded
                        : Icons.inventory_2_rounded,
                    color: statusColor,
                  ),
                  title: Text(
                    productName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text("Expiry: $expiryStr",
                          style: const TextStyle(color: Colors.white70)),
                      Text("Added: $createdStr",
                          style: const TextStyle(color: Colors.white38)),
                      if (daysLeft != null)
                        Text(
                          daysLeft < 0
                              ? "Expired ${daysLeft.abs()} day(s) ago"
                              : "$daysLeft day(s) left",
                          style: TextStyle(color: statusColor),
                        ),
                    ],
                  ),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(color: statusColor, fontSize: 11),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      // FAB -> opens your Setexpiry form page
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorConstants.mainColor,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add_alert),
        label: const Text('Set Expiry'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Setexpiry()),
          );
        },
      ),
    );
  }
}
