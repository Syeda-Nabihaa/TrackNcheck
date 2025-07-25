import 'package:flutter/material.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';

class AppVersionPage extends StatelessWidget {
  const AppVersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            children: const [
              TitleWidget(text: 'App Version', fontsize: 24,),
              SizedBox(height: 15,),
              Icon(Icons.verified, size: 80, color:ColorConstants.mainColor),
              SizedBox(height: 24),
              Text("TrackNCheck",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text("Version 1.0.0",
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
              SizedBox(height: 12),
              Text("Released: July 2025",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
              SizedBox(height: 24),
              Text("Developed by Team TrackNCheck",
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text("Contact: support@trackncheck.app",
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
