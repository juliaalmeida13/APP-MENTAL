import 'dart:ffi';

class ReadingRating {
  int? id;
  String? readingId;
  String? rating;
  String? comment;
  String? ratingDate;

  ReadingRating(
      {this.id, this.readingId, this.rating, this.comment, this.ratingDate});

  factory ReadingRating.fromJson(Map<String, dynamic> json) {
    return ReadingRating(
        id: json['id'],
        readingId: json['readingId'],
        rating: json['rating'],
        comment: json['comment'],
        ratingDate: json['ratingDate']);
  }
}
