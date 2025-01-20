import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Using provider for state management
class QuestionsProvider extends ChangeNotifier {
  static const String apiUrl = 'https://api.jsonserve.com/Uw5CrX';

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

  // Fetching data from the API
  Future<Map<String, dynamic>> getQuestions() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load questions');
      }
    } on HttpException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }
}
