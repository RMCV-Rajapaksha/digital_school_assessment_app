import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:digital_school_assessment_app/componnent/table.dart';
import 'package:flutter/material.dart';

class AdminShowData extends StatefulWidget {
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

  const AdminShowData(
      {Key? key,
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
      required this.sem8Gpa})
      : super(key: key);

  @override
  _AdminShowDataState createState() => _AdminShowDataState();
}

class _AdminShowDataState extends State<AdminShowData> {
  late String _registrationNumber;
  late String name;
  late String mobileNumber;
  late double sem1Gpa;
  late double sem2Gpa;
  late double sem3Gpa;
  late double sem4Gpa;
  late double sem5Gpa;
  late double sem6Gpa;
  late double sem7Gpa;
  late double sem8Gpa;

  @override
  void initState() {
    super.initState();
    _registrationNumber = widget.registerNumber;
    sem1Gpa = widget.sem1Gpa;
    sem2Gpa = widget.sem2Gpa;
    sem3Gpa = widget.sem3Gpa;
    sem4Gpa = widget.sem4Gpa;
    sem5Gpa = widget.sem5Gpa;
    sem6Gpa = widget.sem6Gpa;
    sem7Gpa = widget.sem7Gpa;
    sem8Gpa = widget.sem8Gpa;
    name = widget.name;
    mobileNumber = widget.mobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Template(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      theChild: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'STUDENT DETAILS',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                width: screenWidth * 0.95,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    _buildDetailRow('Name', name),
                    _buildDetailRow('Reg No', _registrationNumber),
                    _buildDetailRow('Mobile No', mobileNumber),
                    SizedBox(height: screenHeight * 0.01),
                    GPATable(
                        gpaData:
                            _buildGPAData()), // Use the GPATable widget here
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '$label : - ',
          style: const TextStyle(color: Colors.white, fontSize: 18),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildGPAData() {
    List<Map<String, dynamic>> gpaData = [
      {'semester': 'Semester 1', 'gpa': widget.sem1Gpa},
      {'semester': 'Semester 2', 'gpa': widget.sem2Gpa},
      {'semester': 'Semester 3', 'gpa': widget.sem3Gpa},
      {'semester': 'Semester 4', 'gpa': widget.sem4Gpa},
      {'semester': 'Semester 5', 'gpa': widget.sem5Gpa},
      {'semester': 'Semester 6', 'gpa': widget.sem6Gpa},
      {'semester': 'Semester 7', 'gpa': widget.sem7Gpa},
      {'semester': 'Semester 8', 'gpa': widget.sem8Gpa},
      {
        'semester': 'Average GPA',
        'gpa': (widget.sem1Gpa +
                widget.sem2Gpa +
                widget.sem3Gpa +
                widget.sem4Gpa +
                widget.sem5Gpa +
                widget.sem6Gpa +
                widget.sem7Gpa +
                widget.sem8Gpa) /
            8
      },
    ];

    return gpaData;
  }
}
