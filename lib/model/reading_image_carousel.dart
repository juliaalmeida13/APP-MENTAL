class ReadingImageCarousel {
  int? id;
  final String base64Image;
  final int readingId;

  ReadingImageCarousel({
    this.id,
    required this.base64Image,
    required this.readingId,
  });

  factory ReadingImageCarousel.fromMap(Map<String, dynamic> json) =>
      new ReadingImageCarousel(
        id: json['id'],
        base64Image: json['base64Image'],
        readingId: json['readingId'],
      );

  factory ReadingImageCarousel.fromJson(Map<String, dynamic> json) {
    return ReadingImageCarousel(
      id: json['id'],
      base64Image: json['base64Image'],
      readingId: json['readingId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'base64Image': base64Image,
      'readingId': readingId,
    };
  }
}
