class MessageModel {
  final String text;
  final bool isResearcherSender;
  final String createdAt;

  MessageModel({
    required this.text,
    required this.isResearcherSender,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        text: json['text'],
        isResearcherSender: json['isResearcherSender'],
        createdAt: json['createdAt']);
  }
}
