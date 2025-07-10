import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Login.dart';
import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/controller/SignUpController.dart';

class Signupauth {
  final Signupcontroller signupcontroller = Get.put(Signupcontroller());

  Future<void> handleSignUp({
    required GlobalKey<FormState> formkey,
    required BuildContext context,
    required TextEditingController name,
    required TextEditingController email,
    required TextEditingController number,
    required TextEditingController password,
  }) async {
    if (formkey.currentState!.validate()) {
      await _performSignUp(name, email,number,password);
    } else {
      failedAlert();
    }
  }

 Future<void> _performSignUp(
  TextEditingController name,
  TextEditingController email,
  TextEditingController number,
  TextEditingController password,
) async {
  String username = name.text.trim();
  String useremail = email.text.trim();
  String usernumber = number.text.trim();
  String userpassword = password.text.trim();

  try {
    EasyLoading.show(status: "Registering...");
    UserCredential? userCredential = await signupcontroller.SignUpMethod(
      username,
      useremail,
      userpassword,
      usernumber,
    );
    EasyLoading.dismiss();

    if (userCredential != null) {
      successAlert();
      Get.to(Login());
    } else {
      failedAlert();
    }
  } catch (e) {
    EasyLoading.dismiss();
    failedAlert();
  }
}


  void successAlert() {
    AlertWidget(
      message: "Successfully registered",
      subtext: "Congratulation ypur account has been registered",
      icon: Icons.ac_unit_rounded,
    );
  }

  void failedAlert() {
    AlertWidget(
      message: "Failed Register",
      subtext: "spmething went wrong please try again",
      icon: Icons.ac_unit_rounded,
    );
  }
}
