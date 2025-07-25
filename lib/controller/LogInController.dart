// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trackncheck/components/AlertWidget.dart';

class LogInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  var isVisible = false.obs;

  Future<UserCredential?> LogInMethod(String email, String password) async {
    try {
      EasyLoading.show(status: 'Please Wait');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      Get.dialog(
        AlertWidget(
          message: "Error",
          subtext: e.message ?? 'Some Error occured',
          animation: "assets/animations/error.json",
        ),
      );
    }
    return null;
  }
}
