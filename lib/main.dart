import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Login.dart';
import 'package:trackncheck/SignUp.dart';
import 'package:trackncheck/Welcome.dart';
import 'package:trackncheck/components/navigationBar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp()
    );
  }
}
