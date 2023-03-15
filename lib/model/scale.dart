class Scale {
  String? questionnaireId;
  String? questionnaireName;
  String? availableAt;
  String? userScale;
  int? answeredUntil;
  bool? unanswered;
  bool? notificationStatus;

  Scale(
      {this.questionnaireId,
      this.questionnaireName,
      this.availableAt,
      this.userScale,
      this.answeredUntil,
      this.unanswered,
      this.notificationStatus});

  factory Scale.fromJson(Map<String, dynamic> json) {
    return Scale(
        questionnaireId: json['questionnaireId'],
        questionnaireName: json['questionnaireName'],
        availableAt: json['availableAt'],
        userScale: json['userScale'],
        answeredUntil: json['answeredUntil'],
        unanswered: json['unanswered'],
        notificationStatus: json['notificationStatus']);
  }
}
