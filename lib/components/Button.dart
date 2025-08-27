import 'package:flutter/material.dart';
import 'package:trackncheck/components/constants.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = ColorConstants.mainColor,
    this.textColor = Colors.white,
    this.borderRadius = 26.0,
    this.paddingVertical = 23.0,
    this.paddingHorizontal = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final VoidCallback onPressed;
  final IconData icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
    required this.icon,
    this.borderRadius = 20.0,
    this.paddingVertical = 22.0,
    this.paddingHorizontal = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: ColorConstants.fieldsColor, width: 2),
        ),

        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min, // keeps button tight to content
        children: [
          
          Icon(icon, size: 25,), 
          SizedBox(width: 30), 
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
