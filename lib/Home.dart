import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Login.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/CustomAvatar.dart';
import 'package:trackncheck/components/Logo.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/scanning/Result_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentUser != null) ...[
              Customavatar(
                radius: 20,
                icon: Icons.account_tree_outlined,
                size: 20,
              ),
              SizedBox(width: 5),
              RichText(
                text: TextSpan(
                  text: "Track",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.5,
                    letterSpacing: 3.0,
                  ),
                  children: [
                    TextSpan(
                      text: "N",
                      style: TextStyle(color: ColorConstants.mainColor),
                    ),
                    TextSpan(text: "Check"),
                  ],
                ),
              ),
            ] else ...[
              Customavatar(
                radius: 20,
                icon: Icons.account_tree_outlined,
                size: 20,
              ),
              SizedBox(width: 5),
              RichText(
                text: TextSpan(
                  text: "Track",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.5,
                    letterSpacing: 3.0,
                  ),
                  children: [
                    TextSpan(
                      text: "N",
                      style: TextStyle(color: ColorConstants.mainColor),
                    ),
                    TextSpan(text: "Check"),
                  ],
                ),
              ),
              SizedBox(width: 30),
              ElevatedButton(
                onPressed: () => Get.to(Login()),
                child: Text('Login', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),)
                
              ),
            ],
          ],
        ),
      ),
      backgroundColor: ColorConstants.bgColor,
      body: ResultPage(),
    );
  }
}
