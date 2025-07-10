import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Helper/SignUpAuth.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/InputFields.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/controller/SignUpController.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Signupauth signupauth = Signupauth();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final Signupcontroller signupcontroller = Get.put(Signupcontroller());

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
                SizedBox(
                  child: TitleWidget(text: "Create New Account", fontsize: 35),
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
                        emptyFields: "Please fill out this fields",
                      ),
                      SizedBox(height: 10),
                      Inputfields(
                        controller: email,
                        icon: Icons.email,
                        hintText: "Enter Your Email",
                        emptyFields: "Please fill out this fields",
                        // emailError: "Incorrect Email Format",
                      ),
                      SizedBox(height: 10),

                          Obx(()=>Inputfields(
                        controller: password,
                        icon: Icons.lock,
                        hintText: "Enter Your Password",
                        suffixicon: GestureDetector(
                          onTap: () {
                            signupcontroller.isVisible.toggle();
                          },
                          child:
                              signupcontroller.isVisible.value
                                  ? FaIcon(
                                    FontAwesomeIcons.eyeSlash,
                                    color: Colors.grey,
                                  )
                                  : FaIcon(
                                    FontAwesomeIcons.eye,
                                    color: Colors.grey,
                                  ),
                        ),
                        emptyFields: "Please fill out this field",
                        obscureText: !signupcontroller.isVisible.value,
                      ),),
                      

                      SizedBox(height: 20),

                      SizedBox(
                        width: 450,
                        child: Button(
                          text: "Sign In",
                          onPressed: () {
                            signupauth.handleSignUp(
                              formkey: _formKey,
                              context: context,
                              name: name,
                              email: email,
                              password: password,
                            );
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
