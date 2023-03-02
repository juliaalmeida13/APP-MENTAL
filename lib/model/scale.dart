class Scale {
  String? questionnaireCode;
  String? questionnaireName;
  String? availableAt;
  String? userScale;
  int? answeredUntil;
  bool? unanswered;

  Scale(
      {this.questionnaireCode,
      this.questionnaireName,
      this.availableAt,
      this.userScale,
      this.answeredUntil,
      this.unanswered});

  factory Scale.fromJson(Map<String, dynamic> json) {
    return Scale(
        questionnaireCode: json['questionnaireCode'],
        questionnaireName: json['questionnaireName'],
        availableAt: json['availableAt'],
        userScale: json['userScale'],
        answeredUntil: json['answeredUntil'],
        unanswered: json['unanswered']);
  }
}
