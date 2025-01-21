import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_assignment/models/data_model.dart';
import 'package:quiz_app_assignment/providers/questions_provider.dart';
import 'package:quiz_app_assignment/screens/result_screen.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app_assignment/widgets/option_button.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key, required this.questionData});

  final DataModel questionData;

  @override
  Widget build(BuildContext context) {
    bool isAnswerTrue = true;
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: true);

    int currentQuestionIndex = questionsProvider.currentQuestionIndex;
    void onAnswerTap(bool isAnswerTrue) {
      // This variable was used to display linearProgressIndicator
      questionsProvider.numberOfQuestionsAnswered++;

      // Saving whether the answer was correct or not for the given questionId
      questionsProvider.answer.addAll({'${questionData.question[currentQuestionIndex].id}': isAnswerTrue});

      questionsProvider.currentQuestionIndex++;
    }

    if (currentQuestionIndex < questionData.question.length) {
      // Displaying Questions Screen
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: currentQuestionIndex / questionData.question.length,
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 40, top: 24),
            padding: EdgeInsets.all(28),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 2),
              color: const Color.fromARGB(65, 171, 202, 172),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${currentQuestionIndex + 1}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Correct: +4',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Gap(8),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(192, 244, 67, 70),
                          ),
                          child: Text(
                            'Wrong: -1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(16),
                // Question
                Text(
                  questionData.question[currentQuestionIndex].description,
                  style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 25, 77, 26)),
                ),
                Gap(80),
                // 4 Options button
                for (int i = 0; i < 4; i++)
                  Column(
                    children: [
                      OptionButton(
                        isCorrect: questionData.question[currentQuestionIndex].options[i].isCorrect,
                        onButtonPressed: () {
                          if (questionData.question[currentQuestionIndex].options[i].isCorrect) {
                            isAnswerTrue = true;
                            // Updating marks
                            questionsProvider.marks += questionsProvider.correctAnswerMark;
                          }
                          if (!questionData.question[currentQuestionIndex].options[i].isCorrect) {
                            isAnswerTrue = false;
                            questionsProvider.marks -= questionsProvider.wrongAnswerMark;
                          }

                          onAnswerTap(isAnswerTrue);
                        },
                        label: questionData.question[currentQuestionIndex].options[i].description,
                      ),
                      Gap(8),
                    ],
                  ),
              ],
            ),
          )
        ],
      );
    }

    // Displaying Results Screen
    return ResultScreen(
      questionData: questionData,
    );
  }
}
