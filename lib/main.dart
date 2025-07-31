import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trackncheck/ForgetPassword.dart';

import 'package:trackncheck/Login.dart';
import 'package:trackncheck/AuthSelecctionScreen.dart';
import 'package:trackncheck/SignUp.dart';
import 'package:trackncheck/Welcome.dart';
import 'package:trackncheck/components/AlertWidget.dart';
import 'package:trackncheck/components/navigationBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trackncheck/firebase_options.dart';
import 'package:trackncheck/account.dart';
import 'package:trackncheck/logout.dart';
import 'package:trackncheck/privacy_policy.dart';
import 'package:trackncheck/scanning/Result_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       builder: EasyLoading.init(), 
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
      ),
      home: AuthSelection(),
    );
  }
}
