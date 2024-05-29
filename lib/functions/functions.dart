import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Calculations {
  // shear by id
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

  void addData(
      String regNo,
      String name,
      String mobileNumber,
      double sem1Gpa,
      double sem2Gpa,
      double sem3Gpa,
      double sem4Gpa,
      double sem5Gpa,
      double sem6Gpa,
      double sem7Gpa,
      double sem8Gpa) async {
    final report = <String, dynamic>{
      "regNo": regNo,
      "name": name,
      "mobileNumber": mobileNumber,
      "sem1Gpa": sem1Gpa,
      "sem2Gpa": sem2Gpa,
      "sem3Gpa": sem3Gpa,
      "sem4Gpa": sem4Gpa,
      "sem5Gpa": sem5Gpa,
      "sem6Gpa": sem6Gpa,
      "sem7Gpa": sem7Gpa,
      "sem8Gpa": sem8Gpa,
    };

    if (regNo.isEmpty || name.isEmpty) {
      Get.snackbar(
        "Error",
        "Registration number and name are required",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc(regNo)
          .set(report)
          .then(
            (value) => print("DocumentSnapshot added with ID: $regNo"),
          );
    }
  }

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

  void deleteData(String regNo) async {
    var db = FirebaseFirestore.instance;

    try {
      var docRef = db.collection("users").doc(regNo);
      var docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.delete();
        print("Document deleted");
        Get.snackbar('Success', 'Document successfully deleted');
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
  }
}
