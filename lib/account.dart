import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/app_version.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
// import 'package:trackncheck/history.dart';
import 'package:trackncheck/privacy_policy.dart';

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(backgroundColor: ColorConstants.bgColor),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TitleWidget(text: 'Account', fontsize: 20,),
            SizedBox(height: 15),
            // Profile Card
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.fieldsColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Abc",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "abc@gmail.com",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu Items
            buildListTile(
              Icons.privacy_tip_outlined,
              "Privacy Policy",
              onTap: () => Get.to(PrivacyPolicyPage()),
            ),
            buildListTile(Icons.feedback_outlined, "Send Feedback"),
            buildListTile(
              Icons.info_outline,
              "App Version 1.0.0",
              onTap: () => Get.to(AppVersionPage()),
            ),
            const Spacer(),

            // Logout Button
            SizedBox(
              width: 300,
              child: Button(text: 'Logout', onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white70,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
