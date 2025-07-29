import 'package:flutter/material.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/scanning/Result_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: ResultPage(),
    );
  }
}