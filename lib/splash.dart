import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Welcome.dart';
import 'package:trackncheck/components/Logo.dart';
import 'package:trackncheck/components/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
    void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 3), (){
      Get.offAll(WelcomeScreen());
    });
    }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: ColorConstants.bgColor,),),
          Center(child: Positioned(child: Image.asset('assets/images/Dotted map.png', fit:BoxFit.cover,))),
          Center(child: Positioned(child: LogoWidget()))
        ],
      )
    );
  }
}