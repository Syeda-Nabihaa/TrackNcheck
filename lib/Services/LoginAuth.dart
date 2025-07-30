import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:trackncheck/Home.dart';
import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/components/navigationBar.dart';
import 'package:trackncheck/controller/GetUserDataController.dart';
import 'package:trackncheck/controller/LogInController.dart';
import 'package:flutter/material.dart';

class Loginauth {
  final LogInController loginController = Get.put(LogInController());
  final Getuserdatacontroller getuserdatacontroller = Get.put(
    Getuserdatacontroller(),
  );

  Future<void> handleLogin({
    required GlobalKey<FormState> formkey,
    required BuildContext context,

    required TextEditingController email,
    required TextEditingController password,
  }) async {
    if (formkey.currentState == null || !formkey.currentState!.validate()) {
      failedAlert("Please fill out the fields correctly");
      return;
    }
    String userEmail = email.text.trim();
    String userPassword = password.text.trim();

    UserCredential? userCredential = await loginController.LogInMethod(
      userEmail,
      userPassword,
    );

    if (userCredential == null) return;
    if (!userCredential.user!.emailVerified) {
      failedAlert("Please Verify Your Email");
      return;
    }
    await successAlert();
    Get.offAll(Navigationbar());
  }

Future<void> successAlert() {
    return Get.dialog(
      AlertWidget(
        message: "Successfully LogIn",
        subtext: "Congratulations! Your account has been logged In",
        animation: "assets/animations/Success.json",
      ),
    );
  }

  void failedAlert(String message) {
    Get.dialog(
      AlertWidget(
        message: message,
        subtext: "spmething went wrong please try again",
        animation: "assets/animations/error.json",
      ),
    );
  }
}
