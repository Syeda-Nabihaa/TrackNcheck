import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/CustomAvatar.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';

class AlertWidget extends StatelessWidget {
  final String message;
  final String subtext;
  final IconData icon;


  const AlertWidget({Key? key, required this.message, required this.subtext, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,

      child: Center(
        child: Container(
          width: 300,
          height: 400,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: ColorConstants.bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Customavatar(radius: 50, icon: icon, size: 40),
              SizedBox(height: 20),
              TitleWidget(text: message, fontsize: 30),
              SizedBox(height: 20),
              SubTitle(
                text: subtext,
              ),
              SizedBox(height: 20,),
              SizedBox(width: 150,child: Button(text: "Ok", onPressed: (){}))
            ],
          ),
        ),
      ),
    );
  }
}
