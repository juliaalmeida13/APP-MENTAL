import 'dart:convert';
import 'dart:ffi';

import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_mental/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import '../model/reading_rating.dart';

final String url = dotenv.env['BACKEND_URL']!;

class UserService {
  Future<UserApp> signupWithEmailAndPasswordAndName(
      String name, String email, String password) async {
    final response = await http.post(Uri.parse("${url}createAppUser"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'name': name,
          'password': md5.convert(utf8.encode(password)).toString(),
          'imageUrl': 'https://i.pravatar.cc/300'
        }));
    if (response.statusCode == 200) {
      return UserApp.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  addNewReadingRating(
      String email, String readingId, double rating, String comment) async {
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

  Future<ReadingRating> findReadingRating(
      String email, String readingId) async {
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
}
