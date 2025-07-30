import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/model/UserModel.dart';

class Signupcontroller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var isVisible = false.obs;

  Future<UserCredential?> SignUpMethod(
    String name,
    String email,

    String password,
  ) async {
    try {
      EasyLoading.show(status: 'Please wait');
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();

      Usermodel usermodel = Usermodel(
        id: userCredential.user!.uid,
        name: name,
        email: email,

        password: password,
      );

      _firebaseFireStore
          .collection('User')
          .doc(userCredential.user!.uid)
          .set(usermodel.toMap());
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

      // Get.snackbar(
      //   'Error',
      //   e.message ?? 'Some Error Occured..',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      //   margin: EdgeInsets.all(16),
      //   borderRadius: 8,
      //   icon: Icon(Icons.error, color: Colors.white),
      // );
    }
    return null;
  }

  Future<UserCredential?> signUpWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web sign-in
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        return await _auth.signInWithPopup(authProvider);
      } else {
        // Android/iOS sign-in
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return null; // Cancelled

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print('Google sign-in error: $e');
      return null;
    }
  }
}
