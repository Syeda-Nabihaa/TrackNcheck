import 'package:flutter/material.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/InputFields.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';

class Login extends StatelessWidget {
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
                SizedBox(child: TitleWidget(text: "Hello Again!",fontsize: 35,)),
                SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: SubTitle(text: "Welcome Back You've been missed"),
                ),
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
                        icon: Icons.lock,
                        hintText: "Enter Your Password",
                        // suffixicon: Icons.remove_red_eye,
                        emptyFields: "Please fill out this fields",
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      SizedBox(
                        width: 450,
                        child: Button(
                          text: "Sign In",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // All fields are valid, proceed with login
                              print("Form is valid");
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
