import 'package:device_preview/device_preview.dart';
import 'package:digital_school_assessment_app/Screens/Admin/adminMain.dart';
import 'package:digital_school_assessment_app/Screens/Admin/update.dart';
import 'package:digital_school_assessment_app/Screens/Students/show.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    DevicePreview(enabled: true, builder: (context) => StuShowData()),
  );
}
