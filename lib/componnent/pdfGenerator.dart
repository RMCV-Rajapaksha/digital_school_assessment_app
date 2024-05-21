import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> t(
    String regNo, List<double> semesterGPAs, double averageGPA) async {
  // Load the font data from the asset file
  final ByteData fontData =
      await rootBundle.load('assets/fonts/NotoSans-Regular.ttf');

  // Create a pw.Font object from the loaded font data
  final pw.Font myFont = pw.Font.ttf(fontData.buffer.asByteData());

  // Create a PDF document
  final pdf = pw.Document();

  // Add a page to the document
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                'Student Report',
                style: pw.TextStyle(
                  fontSize: 25,
                  font: myFont, // Use the custom font here
                ),
              ),
              pw.Text(
                'Student Registration Number: $regNo',
                style: pw.TextStyle(
                  fontSize: 20,
                  font: myFont, // Use the custom font here
                ),
              ),
              pw.SizedBox(height: 20),
              for (var i = 0; i < semesterGPAs.length; i++)
                pw.Text(
                  'Semester ${i + 1} GPA: ${semesterGPAs[i]}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    font: myFont, // Use the custom font here
                  ),
                ),
              pw.Text(
                'Average GPA: $averageGPA',
                style: pw.TextStyle(
                  fontSize: 16,
                  font: myFont, // Use the custom font here
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // Save the PDF document to a file
  final file = File('student_report1.pdf');
  await file.writeAsBytes(await pdf.save());

  // Show a snackbar notification
  Get.snackbar("Save", "PDF generated successfully!");
}
