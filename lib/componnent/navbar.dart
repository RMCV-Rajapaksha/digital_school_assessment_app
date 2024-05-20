import 'package:digital_school_assessment_app/Screens/Admin/add.dart';
import 'package:digital_school_assessment_app/Screens/Admin/update.dart';
import 'package:digital_school_assessment_app/Screens/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  Future<void> Logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Start(),
        ),
      );
      Get.snackbar(
        "Successfully logged out",
        "You have been logged out.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "There was a problem logging out. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayColor: Colors.transparent,
      backgroundColor: const Color.fromARGB(255, 95, 58, 149),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22.0),
      children: [
        SpeedDialChild(
          child: const Icon(
            Icons.update,
            size: 20,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromRGBO(59, 32, 99, 1),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminUpdateDelete()),
            );
          },
          label: 'Update and Delete',
          labelStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
          labelBackgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromRGBO(59, 32, 99, 1),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminAdd()),
            );
          },
          label: 'Add New Student',
          labelStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
          labelBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.signpost_outlined,
            size: 20,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromRGBO(59, 32, 99, 1),
          onTap: () async {
            Logout(context);
          },
          label: 'Logout',
          labelStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
          labelBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ],
    );
  }
}
