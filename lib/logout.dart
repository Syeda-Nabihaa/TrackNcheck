import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/navigationBar.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(backgroundColor: ColorConstants.bgColor),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
  CircleAvatar(
    radius: 50,
    backgroundColor: ColorConstants.fieldsColor,
    child: Icon(Icons.logout_rounded, color: Colors.white, size: 80,),
  ),
  SizedBox(height: 20),
          Text(
            "Log Out",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            "Logging out will end your current session, you can always log back in anytime to access your account",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 10),
          Button(
            text: "Logout",
            onPressed: () {
              FirebaseAuth _auth = FirebaseAuth.instance;
              _auth.signOut();
               AlertWidget(
                                    message: "Successful!",
                                    subtext:
                                        "Your have been logged out.",
                                    animation: "assets/animations/Success.json",
                                  );
              Get.offAll(Navigationbar());
            },
          ),
        ],
      ),
    );
  }
}
