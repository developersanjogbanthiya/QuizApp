import 'package:flutter/material.dart';
import 'package:quiz_app_assignment/models/questions_model.dart';

class DetailedSolution extends StatelessWidget {
  const DetailedSolution({super.key, required this.questionData});
  final Question questionData;

  @override
  Widget build(BuildContext context) {
    // Removing unnecessary line spacing from the solution
    String formattedSolution1 = questionData.detailedSolution.replaceAll('\r\n', '');
    String formattedSolution2 = formattedSolution1.replaceAll('*', '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Solution'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(
            16,
          ),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            color: const Color.fromARGB(65, 171, 202, 172),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(formattedSolution2),
        ),
      ),
    );
  }
}
