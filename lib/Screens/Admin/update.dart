import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:digital_school_assessment_app/componnent/inputFild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUpdateDelete extends StatelessWidget {
  const AdminUpdateDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String searchId;

    final TextEditingController searchController = TextEditingController();
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

    // get user data
    Future<void> getUserDocument(String searchId) async {
      var db = FirebaseFirestore.instance;
      try {
        DocumentSnapshot doc = await db.collection('users').doc(searchId).get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          registerNumberController.text = data['regNo'] ?? '';
          nameController.text = data['name'] ?? '';
          mobileNumberController.text = data['mobileNumber'] ?? '';
          sem1GpaController.text = data['sem1Gpa']?.toString() ?? '';
          sem2GpaController.text = data['sem2Gpa']?.toString() ?? '';
          sem3GpaController.text = data['sem3Gpa']?.toString() ?? '';
          sem4GpaController.text = data['sem4Gpa']?.toString() ?? '';
          sem5GpaController.text = data['sem5Gpa']?.toString() ?? '';
          sem6GpaController.text = data['sem6Gpa']?.toString() ?? '';
          sem7GpaController.text = data['sem7Gpa']?.toString() ?? '';
          sem8GpaController.text = data['sem8Gpa']?.toString() ?? '';
        } else {
          print("No such document!");
          Get.snackbar(
            'Error',
            'No such document!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
          );
        }
      } catch (error) {
        print("Error getting document: $error");
        Get.snackbar(
          'Error',
          'Error getting document',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      }
    }

//update data

    Future<void> updateData(List<dynamic> array) async {
      var db = FirebaseFirestore.instance;

      if (array[0].isBlank) {
        Get.snackbar(
          'Error',
          'Please enter a valid registration number',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
        return;
      } else {
        try {
          await db.collection('users').doc(array[0]).update({
            "regNo": array[0],
            "name": array[1],
            "mobileNumber": array[2],
            "sem1Gpa": array[3],
            "sem2Gpa": array[4],
            "sem3Gpa": array[5],
            "sem4Gpa": array[6],
            "sem5Gpa": array[7],
            "sem6Gpa": array[8],
            "sem7Gpa": array[9],
            "sem8Gpa": array[10],
          });
          print('Data updated successfully');
          Get.snackbar(
            'Success',
            'Data updated successfully',
            snackPosition: SnackPosition.BOTTOM,
          );
        } catch (error) {
          print(
            'Error updating data: $error',
          );
        }
      }
    }

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
                  'ADD OR DELETE DETAILS',
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
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
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
                        searchId = searchController.text;
                        getUserDocument(searchId);
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
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(20.0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.4,
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
                              List<dynamic> array = [
                                registerNumberController.text,
                                nameController.text,
                                mobileNumberController.text,
                                sem1GpaController.text,
                                sem2GpaController.text,
                                sem3GpaController.text,
                                sem4GpaController.text,
                                sem5GpaController.text,
                                sem6GpaController.text,
                                sem7GpaController.text,
                                sem8GpaController.text,
                              ];

                              updateData(array);
                            },
                            child: const Text(
                              'Update Data',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.4,
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
                              var db = FirebaseFirestore.instance;
                              searchId = searchController.text;

                              try {
                                var docRef =
                                    db.collection("users").doc(searchId);
                                var docSnapshot = await docRef.get();

                                if (docSnapshot.exists) {
                                  await docRef.delete();
                                  print("Document deleted");
                                  Get.snackbar('Success',
                                      'Document successfully deleted');
                                } else {
                                  print("Document does not exist");
                                  Get.snackbar(
                                    'Error',
                                    'Document does not exist',
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                  );
                                }
                              } catch (e) {
                                print("Error: $e");
                                Get.snackbar(
                                  'Error',
                                  'Error deleting document',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            child: const Text(
                              'Delete Data',
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
