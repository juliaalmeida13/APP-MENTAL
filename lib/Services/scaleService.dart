import 'dart:convert';

import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:app_mental/model/scale.dart';

import 'api.dart';

class ScaleService {
  Future<List<Scale>> listUnansweredQuestionnaires(String email) async {
    final response =
        await Api().get("listUnansweredQuestionnaires?email=$email");
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
    final response = await Api().get("listAnsweredQuestionnaires?email=$email");
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

  Future<int> getQuestionnaireIsReadCount(String email) async {
    final response =
        await Api().get("getQuestionnaireIsReadCount?email=$email");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}
