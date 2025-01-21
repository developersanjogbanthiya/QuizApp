import 'package:flutter/material.dart';
import 'package:quiz_app_assignment/models/data_model.dart';
import 'package:quiz_app_assignment/services/https_service.dart';

// Using provider for state management
class QuestionsProvider extends ChangeNotifier {
  int numberOfQuestionsAnswered = 0;
  int _currentQuestionIndex = 0;

  int get currentQuestionIndex => _currentQuestionIndex;

  set currentQuestionIndex(int newValue) {
    _currentQuestionIndex = newValue;
    notifyListeners();
  }

  Map<String, bool> answer = {};

  int marks = 0;
  int correctAnswerMark = 4;
  int wrongAnswerMark = 1;

  // Fetching data from the API HTTP Service
  Future<DataModel> getQuestions() async {
    final questionData = await HttpsService().getQuestions();
    return questionData;
  }
}
