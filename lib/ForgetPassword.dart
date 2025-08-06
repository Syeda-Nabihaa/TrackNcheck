import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/InputFields.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/controller/ForgetPasswordController.dart';
// import 'package:trackncheck/controller/LogInController.dart';

class Forgetpassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ForgerPasswordController _forgerPasswordController = Get.put(
      ForgerPasswordController(),
    );
    // final LogInController logInController = Get.put(LogInController());
    TextEditingController email = TextEditingController();
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height, // full screen height
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: TitleWidget(text: "Forgot Password?", fontsize: 35),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 250,
                child: SubTitle(
                  fontsize: 17,
                  text: "We'll send you a email for updating password",
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 450,
                child: Column(
                  children: [
                    Inputfields(
                      controller: email,
                      icon: Icons.email,
                      hintText: "Enter Your Email",
                      emptyFields: "Please fill out this fields",
                      emailError: "Incorrect Email Format",
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(
                width: 450,
                child: Button(
                  text: "Sign In",
                  onPressed: () async {
                    if (_formKey.currentContext != null &&
                        _formKey.currentState!.validate()) {
                      String useremail = email.text.trim();
                      await _forgerPasswordController.forgetPassword(useremail);
                    } else {
                      Get.dialog(
                        AlertWidget(
                          message: "error occured",
                          subtext: "please try again",
                          animation: "assets/animations/error.json",
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
