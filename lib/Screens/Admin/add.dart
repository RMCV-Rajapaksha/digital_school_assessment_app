import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:digital_school_assessment_app/componnent/inputFild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAdd extends StatelessWidget {
  const AdminAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final TextEditingController registerNumberController =
        TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController mobileNumberController =
        TextEditingController();
    final TextEditingController sem1GpaController = TextEditingController();
    final TextEditingController sem2GpaController = TextEditingController();
    final TextEditingController sem3GpaController = TextEditingController();
    final TextEditingController sem4GpaController = TextEditingController();
    final TextEditingController sem5GpaController = TextEditingController();
    final TextEditingController sem6GpaController = TextEditingController();
    final TextEditingController sem7GpaController = TextEditingController();
    final TextEditingController sem8GpaController = TextEditingController();

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
                  'ADD DETAILS',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextFormField(
                      hintText: 'Reg No',
                      controller: registerNumberController,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Mobile number',
                      controller: mobileNumberController,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Semester 1 GPA',
                      controller: sem1GpaController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Semester 2 GPA',
                      controller: sem2GpaController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Semester 3 GPA',
                      controller: sem3GpaController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Semester 4 GPA',
                      controller: sem4GpaController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Semester 5 GPA',
                      controller: sem5GpaController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Semester 6 GPA',
                      controller: sem6GpaController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Semester 7 GPA',
                      controller: sem7GpaController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    CustomTextFormField(
                      hintText: 'Semester 8 GPA',
                      controller: sem8GpaController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.015),
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
                        onPressed: () {
                          // Add your button functionality here
                          String registerNumber = registerNumberController.text;
                          String name = nameController.text;
                          String mobileNumber = mobileNumberController.text;
                          String sem1Gpa = sem1GpaController.text;
                          String sem2Gpa = sem2GpaController.text;
                          String sem3Gpa = sem3GpaController.text;
                          String sem4Gpa = sem4GpaController.text;
                          String sem5Gpa = sem5GpaController.text;
                          String sem6Gpa = sem6GpaController.text;
                          String sem7Gpa = sem7GpaController.text;
                          String sem8Gpa = sem8GpaController.text;

                          print(
                              'Register Number: $registerNumber, Name: $name, Mobile: $mobileNumber');
                          print(
                              'Semester GPAs: $sem1Gpa, $sem2Gpa, $sem3Gpa, $sem4Gpa, $sem5Gpa, $sem6Gpa, $sem7Gpa, $sem8Gpa');
                          // Implement the actual form submission logic here
                        },
                        child: const Text(
                          'Add Data',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
