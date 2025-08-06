import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final double fontsize;
  const TitleWidget({super.key, required this.text, required this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontsize,
        color: Colors.white,
        letterSpacing: 3.0,
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  final String text;
    final double fontsize;


  const SubTitle({super.key, required this.text, required this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        fontSize: fontsize,
        color: Colors.grey,
        letterSpacing: 2.0,
      ),
    );
  }
}

