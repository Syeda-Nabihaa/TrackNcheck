import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trackncheck/SetExpiry.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trackncheck/Welcome.dart';
import 'package:trackncheck/components/navigationBar.dart';
import 'package:trackncheck/controller/ScanHistoryController.dart';
import 'package:trackncheck/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(ScanHistoryController()); // Scan History Controller
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
      home: Navigationbar()
    );
  }
}
