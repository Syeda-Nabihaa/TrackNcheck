import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/account.dart';
import 'package:trackncheck/privacy_policy.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
      ),
      home: UserAccountPage(),
    );
  }
}
