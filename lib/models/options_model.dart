class Option {
  Option(this.id, this.description, this.isCorrect);

  int id;
  String description;
  bool isCorrect;

  factory Option.fromJson(Map<String, dynamic> jsonData) {
    return Option(jsonData['id'], jsonData['description'], jsonData['is_correct']);
  }
}
