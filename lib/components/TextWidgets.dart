import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  const TitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35,
        color: Colors.white,
        letterSpacing: 3.0
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  final String text;
  
  const SubTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        fontSize: 17,
        color: Colors.grey,
         letterSpacing: 2.0
      ),
    );
  }
}
