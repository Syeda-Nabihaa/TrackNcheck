import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/AuthSelecctionScreen.dart';
// import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/CustomAvatar.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/navigationBar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Customavatar(
              radius: 110,
              icon: Icons.account_tree_outlined,
              size: 100,
            ),

            SizedBox(height: 20),
            SizedBox(
              child: RichText(
                textAlign: TextAlign.center,

                text: TextSpan(
                  text: "Welcome To \n",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.5,
                    letterSpacing: 3.0,
                  ),

                  children: [
                    TextSpan(text: "Track"),

                    TextSpan(
                      text: "N",
                      style: TextStyle(color: ColorConstants.mainColor),
                    ),
                    TextSpan(text: "Check"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              "Your daily product safety assistant.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 3.0,
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              width: 300,
              child: Button(
                text: "Get Started",
                onPressed: () {
                  Get.offAll(AuthSelection());
                  // showDialog(
                  //   context: context,
                  //   barrierDismissible: true,
                  //   builder: (_) => AlertWidget(message: "Successfully registerd", subtext: "congratulation you made it", icon: Icons.ac_unit_outlined,),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
