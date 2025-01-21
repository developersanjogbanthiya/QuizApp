import 'package:http/http.dart' as http;
import 'package:quiz_app_assignment/models/data_model.dart';
import 'dart:convert';
import 'dart:io';

class HttpsService {
  static const String apiUrl = 'https://api.jsonserve.com/Uw5CrX';

  // Fetching data from the API
  Future<DataModel> getQuestions() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final jsonData = json.decode(response.body);
        final dataModel = DataModel.fromJson(jsonData);
        return dataModel;
      } else {
        throw Exception('Failed to load questions');
      }
    } on HttpException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }
}
