class AudioDiaryClass {
  int? id;
  final String userEmail;
  final String audioPath;

  AudioDiaryClass({this.id, required this.userEmail, required this.audioPath});

  factory AudioDiaryClass.fromMap(Map<String, dynamic> json) =>
      new AudioDiaryClass(
        id: json['id'],
        userEmail: json['userEmail'],
        audioPath: json['audioPath'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmail': userEmail,
      'audioPath': audioPath,
    };
  }
}
