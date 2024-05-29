import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:digital_school_assessment_app/componnent/pdfGenerator.dart';
import 'package:digital_school_assessment_app/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StuShowData extends StatefulWidget {
  const StuShowData({Key? key}) : super(key: key);

  @override
  _StuShowDataState createState() => _StuShowDataState();
}

Map<String, dynamic> _userData = {};
double gpaAverage = 0;

Calculations calculations = Calculations();

class _StuShowDataState extends State<StuShowData> {
  final TextEditingController _searchController = TextEditingController();

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
                  'YOUR DETAILS',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search using Reg No',
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        fillColor: const Color.fromRGBO(255, 255, 255, 0.1),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                      width: screenWidth *
                          0.02), // Add some spacing between the search bar and button
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(80, 23, 148, 1),
                          Color.fromRGBO(60, 112, 161, 1),
                        ],
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        String regNo = _searchController.text;
                        _userData = await calculations.getUserDocument(regNo);
                        gpaAverage = calculations.calculateAverage(_userData);
                        setState(() {
                          _userData;
                          gpaAverage;
                        });
                      },
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900, // Increased boldness
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: screenWidth * 0.95,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      alignment: Alignment.centerLeft, // Align text to the left
                      child: RichText(
                        text: TextSpan(
                          text: 'Name : - ', // Default style
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18), // White text color
                          children: <TextSpan>[
                            TextSpan(
                              text: _userData['name'] ?? ' ',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white), // White text color
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Reg No : - ',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: _userData['regNo'] ?? ' ',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Mobile No : - ',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: _userData['mobileNumber'] ?? ' ',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Semester ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'GPA',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text(
                              'Semester 1',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              _userData['sem1Gpa'] ?? '0',
                              style: const TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text(
                              'Semester 2',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              _userData['sem2Gpa'] ?? '0',
                              style: const TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text(
                              'Semester 3',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              _userData['sem3Gpa'] ?? '0',
                              style: const TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text(
                              'Semester 4',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              _userData['sem4Gpa'] ?? '0',
                              style: const TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text(
                              'Semester 5',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              _userData['sem5Gpa'] ?? '0',
                              style: const TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text(
                              'Semester 6',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              _userData['sem6Gpa'] ?? '0',
                              style: const TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text(
                              'Semester 7',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              _userData['sem7Gpa'] ?? '0',
                              style: const TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text(
                              'Semester 8',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              _userData['sem8Gpa'] ?? '0',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text(
                              'Average GPA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )),
                            DataCell(Text(
                              gpaAverage.toString(),
                              style: const TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        // Add more DataRows here
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(80, 23, 148, 1),
                      Color.fromRGBO(60, 112, 161, 1),
                    ],
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    List<double> semesterGPAs = [
                      3.5,
                      3.6,
                      3.7,
                      3.8,
                      3.9,
                      4.0,
                      4.0,
                      4.0
                    ];
                    double averageGPA = 3.875; // Example average GPA
                    await t('EG20214733', semesterGPAs, averageGPA);
                  },
                  child: const Text(
                    'Get Result as a PDF',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
