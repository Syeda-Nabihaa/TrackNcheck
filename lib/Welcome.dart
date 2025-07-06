import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Home.dart';
import 'package:trackncheck/components/Button.dart';
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
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 33, 47, 243).withValues(),
                    blurRadius: 10,
                    offset: Offset(0, 7), // shadow direction: bottom right
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: ColorConstants.mainColor,
                radius: 110,
                child: Icon(
                  Icons.account_tree_outlined,
                  color: Colors.white,
                  size: 100,
                ),
              ),
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
              width: 350,
              child: Button(
                text: "Get Started",
                onPressed: () {
                  Get.offAll(Navigationbar());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
