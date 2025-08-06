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
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: ColorConstants.cardColor,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: ColorConstants.fieldsColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.mainColor.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Customavatar(
                radius: 25,
                icon: Icons.camera_alt_outlined,
                size: 20,
              ),
              const SizedBox(height: 12),
              TitleWidget(text: title, fontsize: 17),
              const SizedBox(height: 10),
              SubTitle(text: description, fontsize: 16),
            ],
          ),
        ),
      ),
    );
  }
}



class ResultCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final bool showSubtitle;
  final String? subtitle;

  const ResultCard({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.showSubtitle = false,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstants.cardColor,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: ColorConstants.fieldsColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.mainColor.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      margin: const EdgeInsets.all(16),
     
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 60),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            if (showSubtitle && subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
