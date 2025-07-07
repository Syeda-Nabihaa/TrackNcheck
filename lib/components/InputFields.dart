import 'package:flutter/material.dart';
import 'package:trackncheck/components/constants.dart';

class Inputfields extends StatelessWidget {
  final Color bgcolor;
  final Color color;
  final IconData icon;
  final String hintText;

  const Inputfields({
    super.key,
    this.bgcolor = ColorConstants.fieldsColor,
    this.color = Colors.grey,
    required this.icon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
        filled: true,
        fillColor: bgcolor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          // borderSide: BorderSide(color: bgcolor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          // borderSide: BorderSide(color: bgcolor),
        ),
        hintText: "Enter Your Email",
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(icon, color: color),
      ),
    );
  }
}
