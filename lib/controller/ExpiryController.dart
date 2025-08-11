import 'package:cloud_firestore/cloud_firestore.dart';

class Expirycontroller {
  static FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  static Future<void> saveExpiryReminder({
    required String productName,
    required DateTime expiryDate,
  }) async {
    await _firebaseFireStore.collection('expiry_reminders').add({
      'product_name': productName.trim(),
      'expiry_date': Timestamp.fromDate(expiryDate),
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
