import 'package:flutter/material.dart';
import 'package:trackncheck/components/CustomAvatar.dart';
import 'package:trackncheck/components/Logo.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/scanning/Result_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
        title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Customavatar(
              radius: 20,
              icon: Icons.account_tree_outlined,
              size: 20,
            ),
            SizedBox(width: 5),
           RichText(text: TextSpan(
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
           ))
      ],
    ),
      ),
      backgroundColor: ColorConstants.bgColor,
      body: ResultPage(),
    );
  }
}