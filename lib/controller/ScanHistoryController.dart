import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ScanHistoryController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> scanHistory = <Map<String, dynamic>>[].obs;

  // Call this after every scan
  Future<void> saveScan(String barcode, String result) async {
    final user = _auth.currentUser;

    if (user != null) {
      await _firestore
          .collection('scan_history')
          .doc(user.uid)
          .collection('history')
          .add({
        'barcode': barcode,
        'result': result,
        'timestamp': Timestamp.now(),
      });
    }
  }

  // Fetch history when needed
  Future<void> fetchHistory() async {
    final user = _auth.currentUser;

    if (user != null) {
      final snapshot = await _firestore
          .collection('scan_history')
          .doc(user.uid)
          .collection('history')
          .orderBy('timestamp', descending: true)
          .get();

      scanHistory.value =
          snapshot.docs.map((doc) => doc.data()).toList();
          
    }
  }

  bool get isUserLoggedIn => _auth.currentUser != null;
}
