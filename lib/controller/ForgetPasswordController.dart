// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trackncheck/components/AlertWidget.dart';

class ForgerPasswordController extends GetxController {
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> forgetPassword(String useremail) async {
    try {
      EasyLoading.show(status: 'Please Wait');
      await _firebaseAuth.sendPasswordResetEmail(email: useremail);
      update();
      EasyLoading.dismiss();
      Get.dialog(
        AlertWidget(
          message: "Request sent successfuuly",
          subtext: 'Password reset link sent to $useremail',
          animation: "assets/animations/Success.json",
        ),
      );
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.dialog(
        AlertWidget(
          message: "Error",
          subtext: e.message ?? "some error occured , try again",
          animation: "assets/animations/rrror.json",
        ),
      );
    }
  }
}
