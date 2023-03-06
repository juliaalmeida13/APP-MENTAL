import 'dart:convert';

import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String url = dotenv.env['BACKEND_URL']!;

class QuestionnaireService {
  Future<void> addQuestionnaireAnswer(String email, Object answer, Object score,
      int dom, String scale, int questionIndex) async {
    final response = await http.post(Uri.parse("${url}addQuestionnaireAnswer"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'answer': answer,
          'score': score,
          'dom': dom,
          'scale': scale,
          'ordination': questionIndex
        }));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<dynamic>> getQuestions(String code) async {
    final response = await http.get(
      Uri.parse("${url}getQuestions?code=$code"),
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

  Future<void> discardAllAnswers(String email, String scale) async {
    final response = await http.post(Uri.parse("${url}discardAllAnswers"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'email': email, 'scale': scale}));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<dynamic>> getScore(String email, String scale) async {
    final response = await http.get(
        Uri.parse("${url}getScore?email=$email&scale=$scale"),
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
}
