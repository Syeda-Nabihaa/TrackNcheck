import 'package:flutter/material.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/InputFields.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height, // full screen height
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(child: TitleWidget(text: "Create New Account")),
                SizedBox(height: 20),

                SizedBox(
                  width: 450,
                  child: Column(
                    children: [
                      Inputfields(
                        icon: Icons.email,
                        hintText: "Enter Your Email",
                        emptyFields: "Please fill out this fields",
                        emailError: "Incorrect Email Format",
                      ),
                      SizedBox(height: 10),
                      Inputfields(
                        icon: Icons.phone,
                        hintText: "Enter Your Phone Number",

                        emptyFields: "Please fill out this fields",
                      ),
                      SizedBox(height: 10),
                      Inputfields(
                        icon: Icons.lock,
                        hintText: "Enter Your Password",
                        suffixIcon: Icons.remove_red_eye,
                        emptyFields: "Please fill out this fields",
                      ),

                      SizedBox(height: 20),

                      SizedBox(
                        width: 450,
                        child: Button(
                          text: "Sign In",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("sign up successfuly");
                            } else {
                              // Validation failed
                              print("Form is invalid");
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
