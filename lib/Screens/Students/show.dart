import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:digital_school_assessment_app/componnent/pdfGenerator.dart';
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

class _StuShowDataState extends State<StuShowData> {
  final TextEditingController _searchController = TextEditingController();

  Future<Map<String, dynamic>> getUserDocument(String searchId) async {
    var db = FirebaseFirestore.instance;

    if (searchId.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a registration number',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
      throw Exception("Please enter a registration number");
    } else {
      try {
        DocumentSnapshot doc = await db.collection('users').doc(searchId).get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return data;
        } else {
          print("No such document!");
          Get.snackbar(
            'Error',
            'No such document!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
          );
          throw Exception("No such document!");
        }
      } catch (error) {
        print("Error getting document: $error");
        Get.snackbar(
          'Error',
          'Error getting document',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
        throw Exception("Error getting document: $error");
      }
    }
  }

  double calculateAverage(Map<String, dynamic> allData) {
    double sum = 0;
    int count = 0;
    allData.forEach((key, value) {
      if (key.contains('sem') && value != null) {
        double? gpa = double.tryParse(value);
        if (gpa != null) {
          sum += gpa;
          count++;
        }
      }
    });
    if (sum / count >= 3) {
      Get.snackbar(
        'Great job',
        'You have a high average!',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    }
    return count > 0 ? sum / count : double.nan;
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
                        _userData = await getUserDocument(regNo);
                        gpaAverage = calculateAverage(_userData);
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
