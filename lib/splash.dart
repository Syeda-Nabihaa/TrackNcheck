import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Welcome.dart';
import 'package:trackncheck/components/Logo.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/navigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
   Timer(Duration(seconds: 3), () {
      LoggedIn(context);
    });
  }

 Future<void> LoggedIn(BuildContext context) async {
  if (user != null) {
    Get.offAll(() => Navigationbar());
  } else {
    Get.off(() => WelcomeScreen());
  }
}


  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: ColorConstants.bgColor)),
          // Center(
          //   child: Positioned(
          //     child: Image.asset(
          //       'assets/images/Dotted map.png',
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Center(child: Positioned(child: LogoWidget())),
        ],
      ),
    );
  }
}