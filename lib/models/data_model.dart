import 'package:quiz_app_assignment/models/questions_model.dart';

class DataModel {
  DataModel({required this.id, required this.question});
  int id;
  List<Question> question;

  factory DataModel.fromJson(Map<String, dynamic> jsonData) {
    return DataModel(
      id: jsonData['id'],
      question: (jsonData['questions'] as List).map((question) => Question.fromJson(question)).toList(),
    );
  }
}
