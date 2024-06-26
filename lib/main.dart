import 'package:digital_school_assessment_app/Screens/Admin/adminMain.dart';
import 'package:digital_school_assessment_app/Screens/Admin/login.dart';
import 'package:digital_school_assessment_app/Screens/Admin/registation.dart';
import 'package:digital_school_assessment_app/Screens/Students/login.dart';
import 'package:digital_school_assessment_app/Screens/Students/registation.dart';
import 'package:digital_school_assessment_app/Screens/start.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/Students/show.dart';
import 'firebase_options.dart'; // Ensure this file is correctly generated by the FlutterFire CLI
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Start(),
    );
  }
}
