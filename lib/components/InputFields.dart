import 'package:flutter/material.dart';
import 'package:trackncheck/components/constants.dart';

class Inputfields extends StatelessWidget {
  final Color bgcolor;
  final Color color;
  final IconData icon;
  final Widget? suffixicon;
  final String hintText;
  final String emptyFields;
  final TextEditingController? controller;
  final String? emailError;
  final bool obscureText;


  const Inputfields({
    super.key,
    this.bgcolor = ColorConstants.fieldsColor,
    this.suffixicon,
    
    this.controller,
    required this.emptyFields,

    this.emailError,
    this.color = Colors.grey,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
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
        hintText: hintText,
        prefixIcon: Icon(icon, color: color),
        hintStyle: TextStyle(color: color),
        suffixIcon: suffixicon
      ),

           validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyFields;
        }

        // ✅ Only run email regex if emailError is provided
        if (emailError != null &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return emailError;
        }

        return null;
      },
    );
  }
}
