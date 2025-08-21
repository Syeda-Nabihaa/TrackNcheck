// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:trackncheck/Login.dart';
// import 'package:trackncheck/app_version.dart';
// import 'package:trackncheck/components/Button.dart';
// import 'package:trackncheck/components/TextWidgets.dart';
// import 'package:trackncheck/components/constants.dart';
// import 'package:trackncheck/edit_profile.dart';
// import 'package:trackncheck/logout.dart';
// import 'package:trackncheck/privacy_policy.dart';

// class UserAccountPage extends StatefulWidget {
//   const UserAccountPage({super.key});

//   @override
//   State<UserAccountPage> createState() => _UserAccountPageState();
// }

// class _UserAccountPageState extends State<UserAccountPage> {
//   User? currentUser;

//   @override
//   void initState() {
//     super.initState();
//     currentUser = FirebaseAuth.instance.currentUser;
//   }

//   Future<Map<String, dynamic>?> getUserData() async {
//     if (currentUser == null) return null;

//     final doc = await FirebaseFirestore.instance
//         .collection('User')
//         .doc(currentUser!.uid)
//         .get();

//     if (doc.exists) {
//       return doc.data();
//     } else {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 🔒 If user is not logged in
//     if (currentUser == null) {
//       return Scaffold(
//         backgroundColor: ColorConstants.bgColor,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//     radius: 50,
//     backgroundColor: ColorConstants.fieldsColor,
//     child: Icon(Icons.lock, color: Colors.white, size: 80,),
//   ),
//   SizedBox(height: 20,),
//               Text(
//                 "User isn't logged in",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 10,),
//               TextButton(onPressed: () => Get.to(Login()), child: Text('Go to Login.', style: TextStyle(color: ColorConstants.mainColor, fontSize: 16),))
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: ColorConstants.bgColor,
//       appBar: AppBar(backgroundColor: ColorConstants.bgColor),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('User').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data == null) {
//             return const Center(
//               child: Text(
//                 'User data not found',
//                 style: TextStyle(color: Colors.white),
//               ),
//             );
//           }

//           final user = snapshot.data!.data() as Map<String, dynamic>;
//           return Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: [
//                 TitleWidget(text: 'Account', fontsize: 20),
//                 SizedBox(height: 15),

//                 // Profile Card
//                 Container(
//                   decoration: BoxDecoration(
//                     color: ColorConstants.fieldsColor,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundColor: Colors.grey[300],
//                         child: Text(
//                           user['name'] != null &&
//                                   user['name'].toString().isNotEmpty
//                               ? user['name'][0].toUpperCase()
//                               : '?',
//                           style: const TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: "${user['name']}\n",
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 height: 1.7,
//                               ),
//                             ),
//                             TextSpan(
//                               text: user['email'],
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // Menu Items
//                 buildListTile(
//                   Icons.edit_note_rounded,
//                   "Edit your personal info",
//                   onTap: () => Get.to(EditProfileScreen()),
//                 ),
//                 buildListTile(
//                   Icons.privacy_tip_outlined,
//                   "Privacy Policy",
//                   onTap: () => Get.to(PrivacyPolicyPage()),
//                 ),
//                 buildListTile(Icons.feedback_outlined, "Send Feedback"),
//                 buildListTile(
//                   Icons.info_outline,
//                   "App Version 1.0.0",
//                   onTap: () => Get.to(AppVersionPage()),
//                 ),

//                 const Spacer(),

//                 // Logout Button
//                 SizedBox(
//                   width: 300,
//                   child: Button(
//                     text: 'Logout',
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LogoutScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.white),
//       title: Text(title, style: const TextStyle(color: Colors.white)),
//       trailing: const Icon(
//         Icons.arrow_forward_ios,
//         color: Colors.white70,
//         size: 16,
//       ),
//       onTap: onTap,
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Login.dart';
import 'package:trackncheck/app_version.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/edit_profile.dart';
import 'package:trackncheck/logout.dart';
import 'package:trackncheck/privacy_policy.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key});

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    // 🔒 If user is not logged in
    if (currentUser == null) {
      return Scaffold(
        backgroundColor: ColorConstants.bgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: ColorConstants.fieldsColor,
                child: const Icon(Icons.lock, color: Colors.white, size: 80),
              ),
              const SizedBox(height: 20),
              const Text(
                "User isn't logged in",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Get.to(Login()),
                child: Text(
                  'Go to Login.',
                  style: TextStyle(
                    color: ColorConstants.mainColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: AppBar(backgroundColor: ColorConstants.bgColor),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser!.uid)
            .snapshots(), // ✅ Listen to changes
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'User data not found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final user = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const TitleWidget(text: 'Account', fontsize: 20),
                const SizedBox(height: 15),

                // Profile Card
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.fieldsColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        child: Text(
                          user['name'] != null &&
                                  user['name'].toString().isNotEmpty
                              ? user['name'][0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${user['name']}\n",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.7,
                              ),
                            ),
                            TextSpan(
                              text: user['email'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Menu Items
                buildListTile(
                  Icons.edit_note_rounded,
                  "Edit your personal info",
                  onTap: () => Get.to(EditProfileScreen()),
                ),
                buildListTile(
                  Icons.privacy_tip_outlined,
                  "Privacy Policy",
                  onTap: () => Get.to(PrivacyPolicyPage()),
                ),
                buildListTile(
                  Icons.info_outline,
                  "App Version 1.0.0",
                  onTap: () => Get.to(AppVersionPage()),
                ),

                const Spacer(),

                // Logout Button
                SizedBox(
                  width: 300,
                  child: Button(
                    text: 'Logout',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogoutScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
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
