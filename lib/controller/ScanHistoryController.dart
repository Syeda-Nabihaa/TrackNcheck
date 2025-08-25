import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';

class ScanHistoryController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> scanHistory = <Map<String, dynamic>>[].obs;
  StreamSubscription<QuerySnapshot>? _subscription; 

  Future<void> saveScan({
  required String barcode,
  required String category,
  String? result,
  String? productName,
  String? imageUrl,
  String? expiryDate,
  bool? isExpired,
}) async {
  final user = _auth.currentUser;
  if (user == null) return;

  final historyRef = _firestore
      .collection('scan_history')
      .doc(user.uid)
      .collection('history');

  //Check if product with same barcode + category already exists
  final existing = await historyRef
      .where('barcode', isEqualTo: barcode)
      .where('category', isEqualTo: category)
      .limit(1)
      .get();

  if (existing.docs.isNotEmpty) {
    //Update existing record
    final docId = existing.docs.first.id;
    await historyRef.doc(docId).update({
      'result': result ?? '',
      'productName': productName ?? '',
      'imageUrl': imageUrl ?? '',
      'expiryDate': expiryDate ?? '',
      'isExpired': isExpired ?? false,
      'timestamp': FieldValue.serverTimestamp(), // update timestamp
    });
  } else {
    //Add new entry
    await historyRef.add({
      'barcode': barcode,
      'category': category,
      'result': result ?? '',
      'productName': productName ?? '',
      'imageUrl': imageUrl ?? '',
      'expiryDate': expiryDate ?? '',
      'isExpired': isExpired ?? false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}


  void listenToHistory({String category = 'All'}) {
    final user = _auth.currentUser;
    if (user == null) {
      scanHistory.clear();
      return;
    }

    _subscription?.cancel();

    Query query = _firestore
        .collection('scan_history')
        .doc(user.uid)
        .collection('history')
        .orderBy('timestamp', descending: true);

    if (category != 'All') {
      query = query.where('category', isEqualTo: category);
    }

    _subscription = query.snapshots().listen((snapshot) {
      scanHistory.value = snapshot.docs.map((d) {
        final data = d.data() as Map<String, dynamic>;
        data['id'] = d.id;
        return data;
      }).toList();
    });
  }

  bool get isUserLoggedIn => _auth.currentUser != null;

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
