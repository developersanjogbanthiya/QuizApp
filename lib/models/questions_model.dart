import 'package:quiz_app_assignment/models/options_model.dart';

class Question {
  Question({required this.id, required this.description, required this.detailedSolution, required this.options});

  int id;
  String description;
  String detailedSolution;
  List<Option> options;

  factory Question.fromJson(Map<String, dynamic> jsonData) {
    return Question(
      id: jsonData['id'],
      description: jsonData['description'],
      detailedSolution: jsonData['detailed_solution'],
      options: (jsonData['options'] as List).map((option) => Option.fromJson(option)).toList(),
    );
  }
}
