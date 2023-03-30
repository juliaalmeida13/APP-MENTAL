class QuestionnaireAnswer {
  String? email;
  String? answer;
  Object? score;
  int? domain;
  String? code;
  int? questionIndex;
  String? scale;

  QuestionnaireAnswer(
      {this.email,
      this.answer,
      this.score,
      this.domain,
      this.code,
      this.questionIndex,
      this.scale});

  factory QuestionnaireAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionnaireAnswer(
        email: json['email'],
        answer: json['answer'],
        score: json['score'],
        domain: json['domain'],
        code: json['code'],
        questionIndex: json['questionIndex'],
        scale: json['scale']);
  }
}
