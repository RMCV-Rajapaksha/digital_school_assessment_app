import 'package:digital_school_assessment_app/Screens/Admin/show.dart';
import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:digital_school_assessment_app/componnent/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String registerNumber;
  final String name;
  final String mobileNumber;
  final List<double> gpa;

  Student({
    required this.registerNumber,
    required this.name,
    required this.mobileNumber,
    required this.gpa,
  });

  factory Student.fromFirestore(Map<String, dynamic> data) {
    return Student(
      registerNumber: data['regNo'] ?? '',
      name: data['name'] ?? '',
      mobileNumber: data['mobileNumber'] ?? '',
      gpa: List<double>.generate(8, (index) {
        final gpaValue = data['sem${index + 1}Gpa'];
        return (gpaValue is num)
            ? gpaValue.toDouble()
            : double.tryParse(gpaValue ?? '0') ?? 0.0;
      }),
    );
  }
}

Future<List<Student>> fetchStudents() async {
  try {
    final db = FirebaseFirestore.instance;
    final querySnapshot = await db.collection('users').get();
    return querySnapshot.docs.map((doc) {
      return Student.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    print('Error fetching students: $e');
    return [];
  }
}

class AdminMain extends StatefulWidget {
  const AdminMain({Key? key}) : super(key: key);

  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain>
    with SingleTickerProviderStateMixin {
  late Future<List<Student>> _studentsFuture;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _studentsFuture = fetchStudents();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _refreshStudents() async {
    setState(() {
      _studentsFuture = fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Template(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      theChild: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: CustomNavBar(),
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

                final students = snapshot.data!;
                _animationController.forward();
                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return ScaleTransition(
                      scale: _animation,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        height: screenHeight * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          title: Text(
                            'REG NO: ${student.registerNumber}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          subtitle: Text(
                            student.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminShowData(
                                    registerNumber: student.registerNumber,
                                    name: student.name,
                                    mobileNumber: student.mobileNumber,
                                    sem1Gpa: student.gpa[0],
                                    sem2Gpa: student.gpa[1],
                                    sem3Gpa: student.gpa[2],
                                    sem4Gpa: student.gpa[3],
                                    sem5Gpa: student.gpa[4],
                                    sem6Gpa: student.gpa[5],
                                    sem7Gpa: student.gpa[6],
                                    sem8Gpa: student.gpa[7],
                                  ),
                                ),
                              );
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
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
