import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackncheck/Services/NotificationService.dart';

// import 'package:intl/intl.dart'; 
class Expirycontroller {
  static Future<void> saveExpiryReminder({
    required String productName,
    required DateTime expiryDate,
  }) async {
    try {
      // Save to Firebase
      await FirebaseFirestore.instance.collection('expiry_reminders').add({
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
      final snapshot = await FirebaseFirestore.instance
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

  // Method to update existing reminders
  static Future<void> updateExpiryReminder({
    required String docId,
    required String productName,
    required DateTime expiryDate,
  }) async {
    try {
      // Cancel existing notifications
      await NotificationService().cancelNotification(productName.hashCode);
      
      // Update Firebase
      await FirebaseFirestore.instance
          .collection('expiry_reminders')
          .doc(docId)
          .update({
        'productName': productName,
        'expiryDate': expiryDate,
        'updatedAt': DateTime.now(),
      });

      // Schedule new notifications
      await NotificationService().scheduleMultipleReminders(
        productName: productName,
        expiryDate: expiryDate,
      );

    } catch (e) {
      throw Exception('Failed to update reminder: $e');
    }
  }

  // Method to delete reminder
  static Future<void> deleteExpiryReminder({
    required String docId,
    required String productName,
  }) async {
    try {
      // Cancel notifications
      await NotificationService().cancelNotification(productName.hashCode);
      
      // Delete from Firebase
      await FirebaseFirestore.instance
          .collection('expiry_reminders')
          .doc(docId)
          .delete();

    } catch (e) {
      throw Exception('Failed to delete reminder: $e');
    }
  }
}