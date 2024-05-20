import 'package:digital_school_assessment_app/Screens/Admin/show.dart';
import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:digital_school_assessment_app/componnent/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Define a Student class
class Student {
  final String registerNumber;
  final String name;
  final String mobileNumber;
  final double sem1Gpa;
  final double sem2Gpa;
  final double sem3Gpa;
  final double sem4Gpa;
  final double sem5Gpa;
  final double sem6Gpa;
  final double sem7Gpa;
  final double sem8Gpa;

  Student({
    required this.registerNumber,
    required this.name,
    required this.mobileNumber,
    required this.sem1Gpa,
    required this.sem2Gpa,
    required this.sem3Gpa,
    required this.sem4Gpa,
    required this.sem5Gpa,
    required this.sem6Gpa,
    required this.sem7Gpa,
    required this.sem8Gpa,
  });

  factory Student.fromFirestore(Map<String, dynamic> data) {
    return Student(
      registerNumber: data['regNo'] ?? '',
      name: data['name'] ?? '',
      mobileNumber: data['mobileNumber'] ?? '',
      sem1Gpa: (data['sem1Gpa'] is num)
          ? data['sem1Gpa'].toDouble()
          : double.parse(data['sem1Gpa'] ?? '0'),
      sem2Gpa: (data['sem2Gpa'] is num)
          ? data['sem2Gpa'].toDouble()
          : double.parse(data['sem2Gpa'] ?? '0'),
      sem3Gpa: (data['sem3Gpa'] is num)
          ? data['sem3Gpa'].toDouble()
          : double.parse(data['sem3Gpa'] ?? '0'),
      sem4Gpa: (data['sem4Gpa'] is num)
          ? data['sem4Gpa'].toDouble()
          : double.parse(data['sem4Gpa'] ?? '0'),
      sem5Gpa: (data['sem5Gpa'] is num)
          ? data['sem5Gpa'].toDouble()
          : double.parse(data['sem5Gpa'] ?? '0'),
      sem6Gpa: (data['sem6Gpa'] is num)
          ? data['sem6Gpa'].toDouble()
          : double.parse(data['sem6Gpa'] ?? '0'),
      sem7Gpa: (data['sem7Gpa'] is num)
          ? data['sem7Gpa'].toDouble()
          : double.parse(data['sem7Gpa'] ?? '0'),
      sem8Gpa: (data['sem8Gpa'] is num)
          ? data['sem8Gpa'].toDouble()
          : double.parse(data['sem8Gpa'] ?? '0'),
    );
  }
}

Future<List<Student>> fetchStudents() async {
  try {
    var db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection('users').get();
    return querySnapshot.docs.map((doc) {
      return Student.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    // Print out the error for debugging
    print('Error fetching students: $e');

    return [];
  }
}

class AdminMain extends StatefulWidget {
  const AdminMain({Key? key}) : super(key: key);

  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  late Future<List<Student>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = fetchStudents();
  }

  Future<void> _refreshStudents() async {
    setState(() {
      _studentsFuture = fetchStudents();
    });
  }

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
          child: RefreshIndicator(
            onRefresh: _refreshStudents,
            child: FutureBuilder<List<Student>>(
              future: _studentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No students found'));
                }

                List<Student> students = snapshot.data!;

                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminShowData(
                                      registerNumber:
                                          students[index].registerNumber,
                                      name: students[index].name,
                                      mobileNumber:
                                          students[index].mobileNumber,
                                      sem1Gpa: students[index].sem1Gpa,
                                      sem2Gpa: students[index].sem2Gpa,
                                      sem3Gpa: students[index].sem3Gpa,
                                      sem4Gpa: students[index].sem4Gpa,
                                      sem5Gpa: students[index].sem5Gpa,
                                      sem6Gpa: students[index].sem6Gpa,
                                      sem7Gpa: students[index].sem7Gpa,
                                      sem8Gpa: students[index].sem8Gpa,
                                    ),
                                  ),
                                );
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
