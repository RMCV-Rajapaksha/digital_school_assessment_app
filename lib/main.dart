import 'package:device_preview/device_preview.dart';
import 'package:digital_school_assessment_app/Screens/Admin/adminMain.dart';
import 'package:digital_school_assessment_app/Screens/Admin/login.dart';
import 'package:digital_school_assessment_app/Screens/Admin/update.dart';
import 'package:digital_school_assessment_app/Screens/Students/login.dart';
import 'package:digital_school_assessment_app/Screens/Students/registation.dart';
import 'package:digital_school_assessment_app/Screens/Students/show.dart';
import 'package:digital_school_assessment_app/Screens/start.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const Start(),
    );
  }
}
