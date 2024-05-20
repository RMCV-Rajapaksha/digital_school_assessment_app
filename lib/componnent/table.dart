import 'package:flutter/material.dart';

class GPATable extends StatelessWidget {
  final List<Map<String, dynamic>> gpaData;

  const GPATable({Key? key, required this.gpaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Semester',
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
      rows: _buildGPARows(),
    );
  }

  List<DataRow> _buildGPARows() {
    return gpaData
        .map((data) => DataRow(
              cells: [
                DataCell(Text(
                  data['semester'],
                  style: const TextStyle(color: Colors.white),
                )),
                DataCell(Text(
                  data['gpa'].toString(),
                  style: const TextStyle(color: Colors.white),
                )),
              ],
            ))
        .toList();
  }
}
