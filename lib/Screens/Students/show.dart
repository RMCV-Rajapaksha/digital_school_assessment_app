import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StuShowData extends StatelessWidget {
  const StuShowData({Key? key}) : super(key: key);

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
                      onPressed: () {
                        // Add your button functionality here
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
                width: screenWidth * 0.9,
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
                        text: const TextSpan(
                          text: 'Name : - ', // Default style
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18), // White text color
                          children: <TextSpan>[
                            TextSpan(
                              text: 'R.M.C.V Rajapaksha',
                              style: TextStyle(
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
                        text: const TextSpan(
                          text: 'Reg No : - ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'EG/2021/4733',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
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
                        text: const TextSpan(
                          text: 'Mobile No : - ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: '0779121861',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
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
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Semester 1',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Semester 2',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              '3.7',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Semester 3',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Semester 4',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Semester 5',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Semester 6',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Semester 7',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Semester 8',
                              style: TextStyle(color: Colors.white),
                            )),
                            DataCell(Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                              'Average GPA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )),
                            DataCell(Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
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
            ],
          ),
        ),
      ),
    );
  }
}
