import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Login.dart';
import 'package:trackncheck/SignUp.dart';

import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/navigationBar.dart';
import 'package:trackncheck/controller/SignUpController.dart';

class AuthSelection extends StatelessWidget {
  final Signupcontroller signupcontroller = Get.put(Signupcontroller());
  AuthSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: TitleWidget(text: "Lets Get Started", fontsize: 35),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: SubTitle(text: "Your Daily product safety assistant"),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: CustomButton(
                  text: "Sign Up With Email",
                  onPressed: () {
                    Get.to(SignUp());
                  },
                  color: ColorConstants.fieldsColor,
                  textColor: Colors.white,
                  icon: FontAwesomeIcons.envelope,
                ),
              ),
              SizedBox(height: 20),
              SubTitle(text: "Or use instant sign up"),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: CustomButton(
                  text: "Sign Up With Google",
                  onPressed: () async {
                    var userCredential =
                        await signupcontroller.signUpWithGoogle();
                    if (userCredential != null) {
                      await AlertWidget(
                        message: "${userCredential.user?.displayName}",
                        subtext: "congratulation",
                        animation: "assets/animations/Success.json",
                      );
                      Get.offAll(Navigationbar());
                    }
                  },
                  color: ColorConstants.bgColor,
                  textColor: Colors.white,
                  icon: FontAwesomeIcons.google,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: CustomButton(
                  text: "Sign Up With apple",
                  onPressed: () {},
                  color: ColorConstants.bgColor,
                  textColor: Colors.white,
                  icon: FontAwesomeIcons.apple,
                ),
              ),
              SizedBox(height: 20),
              SubTitle(text: "Already Have An account?"),
              TextButton(
                onPressed: () {
                  Get.to(Login());
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 17,
                    color: ColorConstants.mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
