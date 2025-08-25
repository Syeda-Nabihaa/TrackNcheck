import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackncheck/Services/NotificationService.dart';

class Expirycontroller {
  static Future<void> saveExpiryReminder({
    required String productName,
    required DateTime expiryDate,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // Save to Firebase inside user's subcollection
await FirebaseFirestore.instance
    .collection('expiry_reminders')
    .doc(FirebaseAuth.instance.currentUser!.uid) // user doc
    .collection('items') // subcollection
    .add({
  'productName': productName,
  'expiryDate': expiryDate,
  'createdAt': DateTime.now(),
});


      // Schedule multiple notifications
      await NotificationService().scheduleMultipleReminders(
        productName: productName,
        expiryDate: expiryDate,
      );
    } catch (e) {
      throw Exception('Failed to save reminder: $e');
    }
  }

  static Future<void> scheduleAllPendingNotifications() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('expiry_reminders')
              .where('expiryDate', isGreaterThan: DateTime.now())
              .get();

      for (var doc in snapshot.docs) {
        final productName = doc['productName'];
        final expiryDate = (doc['expiryDate'] as Timestamp).toDate();

        await NotificationService().scheduleMultipleReminders(
          productName: productName,
          expiryDate: expiryDate,
        );
      }
    } catch (e) {
      print('Error scheduling notifications: $e');
    }
  }

  static Future<void> updateExpiryReminder({
    required String docId,
    required String productName,
    required DateTime expiryDate,
  }) async {
    try {
      await NotificationService().cancelNotification(productName.hashCode);

      await FirebaseFirestore.instance
          .collection('expiry_reminders')
          .doc(docId)
          .update({
            'productName': productName,
            'expiryDate': Timestamp.fromDate(expiryDate), // ✅ FIX
            'updatedAt': Timestamp.fromDate(DateTime.now()),
          });

      await NotificationService().scheduleMultipleReminders(
        productName: productName,
        expiryDate: expiryDate,
      );
    } catch (e) {
      throw Exception('Failed to update reminder: $e');
    }
  }

  static Future<void> deleteExpiryReminder({
    required String docId,
    required String productName,
  }) async {
    try {
      await NotificationService().cancelNotification(productName.hashCode);

      await FirebaseFirestore.instance
          .collection('expiry_reminders')
          .doc(docId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete reminder: $e');
    }
  }
}
