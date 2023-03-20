import 'dart:convert';

import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:app_mental/model/scale.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String url = dotenv.env['BACKEND_URL']!;

class ScaleService {
  Future<List<Scale>> listUnansweredQuestionnaires(String email) async {
    final response = await http.get(
        Uri.parse("${url}listUnansweredQuestionnaires?email=$email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    List<Scale> scaleList = [];
    if (response.statusCode == 200) {
      var jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      for (var scale in jsonList) {
        scaleList.add(Scale.fromJson(scale));
      }
      return scaleList;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<List<Scale>> listAnsweredQuestionnaires(String email) async {
    final response = await http.get(
        Uri.parse("${url}listAnsweredQuestionnaires?email=$email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    List<Scale> scaleList = [];
    if (response.statusCode == 200) {
      var jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      for (var scale in jsonList) {
        scaleList.add(Scale.fromJson(scale));
      }
      return scaleList;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<int> getQuestionnaireNotificationStatusCount(String email) async {
    final response = await http.get(
        Uri.parse("${url}getQuestionnaireNotificationStatusCount?email=$email"),
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

  Future<List<dynamic>> getQuestionnaireDateNotification(String email) async {
    final response = await http.get(
        Uri.parse("${url}getQuestionnaireDateNotification?email=$email"),
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
