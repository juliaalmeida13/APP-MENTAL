import 'package:app_mental/model/reading.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';

import 'dart:convert';

import '../model/reading_rating.dart';

final String url = dotenv.env['BACKEND_URL']!;

class ReadingService {
  Future<void> addNewReadingRating(
      String email, int readingId, double rating, String comment) async {
    final response = await http.post(Uri.parse("${url}rateReading"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'readingId': readingId,
          'rating': rating,
          'comment': comment
        }));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<ReadingRating> findReadingRating(String email, int readingId) async {
    final response = await http.get(
      Uri.parse("${url}searchReadingRating?email=$email&readingId=$readingId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) != "") {
        return ReadingRating.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        return ReadingRating();
      }
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<int> getReadingIsReadCount(String email) async {
    final response = await http.get(
        Uri.parse("${url}getReadingIsReadCount?email=$email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<int> getReadingVersion() async {
    final response = await http.get(
      Uri.parse("${url}getReadingVersion"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<void> changeIsRead(String email, String name, String group) async {
    final response = await http.post(Uri.parse("${url}changeIsRead"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'email': email, 'name': name, 'group': group}));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<Reading>> getReadings() async {
    final response = await http.get(
      Uri.parse("${url}getReadings"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    List<Reading> readingList = [];
    if (response.statusCode == 200) {
      var jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      for (var reading in jsonList) {
        readingList.add(Reading.fromJson(reading));
      }
      return readingList;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}
