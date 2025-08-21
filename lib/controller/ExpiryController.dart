import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackncheck/Services/NotificationService.dart';

class Expirycontroller {
  /// Save new product reminder
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

      // Schedule notifications for this product
      await NotificationService().scheduleMultipleReminders(
        productName: productName,
        expiryDate: expiryDate,
      );

      // Optional: immediate notification
      await NotificationService().scheduleImmediateNotification(
        productName: productName,
        expiryDate: expiryDate,
      );

    } catch (e) {
      throw Exception('Failed to save reminder: $e');
    }
  }

  /// Update existing reminder
  static Future<void> updateExpiryReminder({
    required String docId,
    required String productName,
    required DateTime expiryDate,
  }) async {
    try {
      // Cancel old notifications
      await NotificationService().cancelNotification(productName.hashCode + 30);
      await NotificationService().cancelNotification(productName.hashCode + 7);
      await NotificationService().cancelNotification(productName.hashCode + 999);

      // Update in Firebase
      await FirebaseFirestore.instance.collection('expiry_reminders').doc(docId).update({
        'productName': productName,
        'expiryDate': expiryDate,
        'updatedAt': DateTime.now(),
      });

      // Schedule new notifications
      await NotificationService().scheduleMultipleReminders(
        productName: productName,
        expiryDate: expiryDate,
      );

      // Optional: immediate notification
      await NotificationService().scheduleImmediateNotification(
        productName: productName,
        expiryDate: expiryDate,
      );

    } catch (e) {
      throw Exception('Failed to update reminder: $e');
    }
  }

  /// Delete reminder
  static Future<void> deleteExpiryReminder({
    required String docId,
    required String productName,
  }) async {
    try {
      // Cancel all notifications for this product
      await NotificationService().cancelNotification(productName.hashCode + 30);
      await NotificationService().cancelNotification(productName.hashCode + 7);
      await NotificationService().cancelNotification(productName.hashCode + 999);

      // Delete from Firebase
      await FirebaseFirestore.instance.collection('expiry_reminders').doc(docId).delete();

    } catch (e) {
      throw Exception('Failed to delete reminder: $e');
    }
  }
}
