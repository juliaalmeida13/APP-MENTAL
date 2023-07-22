class QuestionModel {
  final int id;
  final bool required;
  final String title;

  QuestionModel({
    required this.id,
    required this.required,
    required this.title,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        id: json['id'], required: json['required'], title: json['title']);
  }
}
