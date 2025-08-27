import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trackncheck/Services/LoginAuth.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/InputFields.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/controller/LogInController.dart';

class Login extends StatelessWidget {
  final Loginauth loginauth = Loginauth();
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final LogInController logInController = Get.put(LogInController());

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
                  child: TitleWidget(text: "Hello Again!", fontsize: 35),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: SubTitle(
                    fontsize: 17,
                    text: "Welcome Back You've been missed",
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 450,
                  child: Column(
                    children: [
                      Inputfields(
                        controller: email,
                        icon: Icons.email,
                        hintText: "Enter Your Email",
                        emptyFields: "Please fill out this fields",
                        emailError: "Incorrect Email Format",
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => Inputfields(
                          controller: password,
                          icon: Icons.lock,
                          hintText: "Enter Your Password",
                          suffixicon: GestureDetector(
                            onTap: () {
                              logInController.isVisible.toggle();
                            },
                            child:
                                logInController.isVisible.value
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
                          obscureText: !logInController.isVisible.value,
                        ),
                      ),
                      SizedBox(height: 20),

                      SizedBox(
                        width: 450,
                        child: Button(
                          text: "Sign In",
                          onPressed: () {
                            loginauth.handleLogin(
                              formkey: _formKey,
                              context: context,
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
