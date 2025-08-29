import 'package:flutter/material.dart';
import 'package:trackncheck/components/CustomAvatar.dart';
import 'package:trackncheck/components/constants.dart';

class LogoWidget extends StatelessWidget {
  final double radius;
  final double size;
  final double fontSize;
  const LogoWidget({super.key, required this.radius, required this.size, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Customavatar(
              radius: radius,
              icon: Icons.account_tree_outlined,
              size: size,
            ),
            SizedBox(height: 20),
           RichText(text: TextSpan(
            text: "Track",
             style: TextStyle(
                    fontSize: fontSize,
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
    );
  }
}