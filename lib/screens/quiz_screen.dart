import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz_app_assignment/providers/questions_provider.dart';
import 'package:quiz_app_assignment/screens/questions_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Quiz App',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
          future: questionsProvider.getQuestions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData) {
              return Center(child: const Text('No Data'));
            } else if (snapshot.hasError) {
              return Center(child: const Text('Error Occurred'));
            }
            return QuestionsScreen(questionData: snapshot.data!);
          }),
    );
  }
}
