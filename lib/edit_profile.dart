import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackncheck/account.dart';
import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/InputFields.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/navigationBar.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) {
      Get.dialog(
        AlertWidget(
          message: "Error",
          subtext: "User not authenticated.",
          animation: "assets/animations/error.json",
        ),
      );
      return;
    }

    try {
      final userDoc = await firestore.collection('User').doc(uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          name.text = data['name'] ?? '';
          email.text = data['email'] ?? '';
        });
      } else {
        Get.dialog(
          AlertWidget(
            message: "Data Missing",
            subtext: "User data could not be found.",
            animation: "assets/animations/error.json",
          ),
        );
      }
    } catch (e) {
      Get.dialog(
        AlertWidget(
          message: "Error Loading Profile",
          subtext: e.toString(),
          animation: "assets/animations/error.json",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
       appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleWidget(text: "Manage Profile", fontsize: 35),
                SizedBox(height: 10),
                SizedBox(
                  width: 380,
                  child: SubTitle(
                    text:
                        "Make sure your information is correct for a better experience.",
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 450,
                  child: Column(
                    children: [
                      Inputfields(
                        controller: name,
                        icon: Icons.account_circle_rounded,
                        hintText: "Enter Your Name",
                        emptyFields: "Please fill out this field",
                      ),
                      SizedBox(height: 10),
                      Inputfields(
                        controller: email,
                        icon: Icons.email_rounded,
                        hintText: "Enter Your Email",
                        emptyFields: "Please fill out this field",
                        readOnly: true,
                      ),

                      SizedBox(height: 20),
                      SizedBox(
                        width: 450,
                        child: Button(
                          text: "Update",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                final uid = auth.currentUser!.uid;
                                await firestore
                                    .collection('User')
                                    .doc(uid)
                                    .update({'name': name.text.trim()});

                                Get.dialog(
                                  AlertWidget(
                                    message: "Successful!",
                                    subtext:
                                        "Congratulations! Your account has been updated.",
                                    animation: "assets/animations/Success.json",
                                  ),
                                );
                              } catch (e) {
                                Get.dialog(
                                  AlertWidget(
                                    message: 'Update Failed',
                                    subtext: "Something went wrong: $e",
                                    animation: "assets/animations/error.json",
                                  ),
                                );
                              }
                            } else {
                              Get.dialog(
                                AlertWidget(
                                  message: 'Error!',
                                  subtext:
                                      "Please complete the required fields.",
                                  animation: "assets/animations/error.json",
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
