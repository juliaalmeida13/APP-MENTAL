class TextDiaryClass {
  int? id;
  final String userEmail;
  final String createdDate;
  final String descriptionText;

  TextDiaryClass(
      {this.id,
      required this.userEmail,
      required this.createdDate,
      required this.descriptionText});

  factory TextDiaryClass.fromMap(Map<String, dynamic> json) =>
      new TextDiaryClass(
        id: json['id'],
        userEmail: json['userEmail'],
        createdDate: json['createdDate'],
        descriptionText: json['descriptionText'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmail': userEmail,
      'createdDate': createdDate,
      'descriptionText': descriptionText,
    };
  }
}
