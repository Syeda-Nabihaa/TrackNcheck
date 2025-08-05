import 'package:flutter/material.dart';
import 'package:trackncheck/components/CustomAvatar.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  const CardWidget({
    required this.title,
    required this.description,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
  onTap: onTap,
  child: Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: ColorConstants.cardColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Customavatar(radius: 25, icon: Icons.camera_alt_outlined, size: 20),
          const SizedBox(height: 12),
          TitleWidget(text: title, fontsize: 16),
          const SizedBox(height: 10),
          SubTitle(
            text: description,

          ),
        ],
      ),
    ),
  )
    );


  }
}
