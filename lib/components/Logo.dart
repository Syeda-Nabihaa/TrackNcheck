import 'package:flutter/material.dart';
import 'package:trackncheck/components/CustomAvatar.dart';
import 'package:trackncheck/components/constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Customavatar(
              radius: 90,
              icon: Icons.account_tree_outlined,
              size: 100,
            ),
            SizedBox(height: 20),
           RichText(text: TextSpan(
            text: "Track",
             style: TextStyle(
                    fontSize: 40,
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