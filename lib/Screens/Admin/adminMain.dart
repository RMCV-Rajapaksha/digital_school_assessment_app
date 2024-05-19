import 'package:digital_school_assessment_app/Screens/Admin/update.dart';
import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:digital_school_assessment_app/componnent/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Sample list of students
final List<Student> students = [
  Student(registerNumber: 'EG/2021/4733', name: 'John Doe'),
  Student(registerNumber: 'EG/2021/4734', name: 'Jane Smith'),
  Student(registerNumber: 'EG/2021/4735', name: 'Alice Johnson'),
  Student(registerNumber: 'EG/2021/4736', name: 'Bob Brown'),
  Student(registerNumber: 'EG/2021/4737', name: 'Charlie Davis'),
  Student(registerNumber: 'EG/2021/4738', name: 'Dana Evans'),
  Student(registerNumber: 'EG/2021/4739', name: 'Eve Foster'),
  Student(registerNumber: 'EG/2021/4740', name: 'Frank Green'),
  Student(registerNumber: 'EG/2021/4741', name: 'Grace Harris'),
  Student(registerNumber: 'EG/2021/4742', name: 'Hank Irving'),
];

// Define a Student class
class Student {
  final String registerNumber;
  final String name;

  Student({required this.registerNumber, required this.name});
}

class AdminMain extends StatelessWidget {
  const AdminMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Template(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      theChild: Scaffold(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        floatingActionButton: CustomNavBar(), // Use CustomNavBar here
        body: SafeArea(
          child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                height: screenHeight * 0.1,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      title: Text(
                        'REG NO: ${students[index].registerNumber}',
                        style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      subtitle: Text(
                        students[index].name,
                        style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/update');
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.info, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              'More Info',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
