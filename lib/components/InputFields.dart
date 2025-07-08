import 'package:flutter/material.dart';
import 'package:trackncheck/components/constants.dart';

class Inputfields extends StatelessWidget {
  final Color bgcolor;
  final Color color;
  final IconData icon;
  final IconData? suffixIcon;
  final String hintText;
  final String emptyFields;
  final String? emailError;
  

  const Inputfields({
    super.key,
    this.bgcolor = ColorConstants.fieldsColor,
    this.suffixIcon,
    required this.emptyFields,
    
    this.emailError,
    this.color = Colors.grey,
    required this.icon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(suffixIcon, color: color),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return emptyFields;
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return emailError;
        }
         return null;
      },
    );
  }
}
