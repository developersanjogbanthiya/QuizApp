import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_assignment/provider/questions_provider.dart';
import 'package:quiz_app_assignment/screens/quiz_screen.dart';

class FrontScreen extends StatelessWidget {
  const FrontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.quiz_rounded,
              size: 160,
              color: Theme.of(context).colorScheme.primary,
            ),
            Gap(12),
            Text(
              'Quiz App',
              style: TextStyle(
                fontSize: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Gap(12),
            ElevatedButton(
              onPressed: () {
                questionsProvider.answer.clear();
                questionsProvider.currentQuestionIndex = 0;
                Navigator.of(context).push(CupertinoPageRoute(builder: (builder) {
                  return QuizScreen();
                }));
              },
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48)),
              child: Text('Start Quiz?'),
            ),
            Gap(16),
            Text(
              'Created by - Sanjog Banthiya',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
