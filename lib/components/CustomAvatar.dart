import 'package:flutter/material.dart';
import 'package:trackncheck/components/constants.dart';

class Customavatar extends StatelessWidget {
  final Color color;
  final Color textColor;
  final double radius;
  final IconData icon;
  final double size;
  const Customavatar({
    super.key,
    this.color = ColorConstants.mainColor,
    this.textColor = Colors.white,
    required this.radius,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 33, 47, 243).withValues(),
            blurRadius: 10,
            offset: Offset(0, 7), // shadow direction: bottom right
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: color,
        radius: radius,
        child: Icon(
          icon,
          color: textColor,
          size: size,
        ),
      ),
    );
  }
}
