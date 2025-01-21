import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_assignment/models/data_model.dart';
import 'package:quiz_app_assignment/providers/questions_provider.dart';
import 'package:quiz_app_assignment/screens/detailed_solution.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.questionData});
  final DataModel questionData;
  @override
  Widget build(BuildContext context) {
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: true);

    return Column(
      children: [
        Gap(12),
        // Displaying score
        Text(
          'Total Score: ${questionsProvider.marks}',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(6),
        Flexible(
          child: ListView(
            children: [
              ...questionData.question.map(
                (element) {
                  return Container(
                    margin: EdgeInsets.all(
                      16,
                    ),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      color: const Color.fromARGB(65, 171, 202, 172),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (questionsProvider.answer['${element.id}']!)
                              // Correct answer marked by user
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Correct: +4 Marks',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            if (!questionsProvider.answer['${element.id}']!)
                              // Wrong answer marked by user
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color.fromARGB(192, 244, 67, 70),
                                ),
                                child: Text(
                                  'Wrong: -1 Mark',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            // Button for Detailed Solution
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(builder: (builder) {
                                  return DetailedSolution(
                                    questionData: element,
                                  );
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromARGB(255, 25, 77, 26)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Detailed Solution',
                                  style: TextStyle(color: const Color.fromARGB(255, 25, 77, 26)),
                                ),
                              ),
                            )
                          ],
                        ),
                        // Question
                        Text(
                          element.description,
                          style: TextStyle(color: const Color.fromARGB(255, 25, 77, 26), fontSize: 16),
                        ),
                        Gap(12),
                        // Options
                        for (int i = 0; i < 4; i++)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(1000, 16),
                              // Right option - green colour
                              backgroundColor: element.options[i].isCorrect
                                  ? const Color.fromARGB(222, 76, 175, 79)
                                  : Color.fromARGB(192, 244, 67, 70),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {},
                            // Option Text
                            child: Text(
                              element.options[i].description,
                            ),
                          ),
                        Gap(12),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Gap(12),
        ElevatedButton(
            onPressed: () {
              questionsProvider.answer.clear();
              questionsProvider.currentQuestionIndex = 0;
            },
            child: Text('Start Again?')),
        Gap(12),
      ],
    );
  }
}
