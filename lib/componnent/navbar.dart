import 'package:digital_school_assessment_app/Screens/Admin/add.dart';
import 'package:digital_school_assessment_app/Screens/Admin/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

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
      ],
    );
  }
}
