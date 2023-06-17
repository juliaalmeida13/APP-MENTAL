import 'dart:convert';

import 'package:app_mental/model/answers.dart';
import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:app_mental/model/questionnaire_answer.dart';

import '../model/score.dart';
import 'api.dart';

class QuestionnaireService {
  Future<void> addQuestionnaireAnswer(
      QuestionnaireAnswer questionnaireAnswer) async {
    final response = await Api().post(
        "addQuestionnaireAnswer",
        jsonEncode(<String, dynamic>{
          'email': questionnaireAnswer.email,
          'answer': questionnaireAnswer.answer,
          'score': questionnaireAnswer.score,
          'domain': questionnaireAnswer.domain,
          'code': questionnaireAnswer.code,
          'order': questionnaireAnswer.questionIndex,
          'scale': questionnaireAnswer.scale
        }));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<dynamic>> getQuestions(String code) async {
    final response = await Api().get("getQuestions?code=$code");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<List<Answers>> getAnswers(String code) async {
    final response = await Api().get("getAnswers?code=$code");
    if (response.statusCode == 200) {
      List<Answers> answersList = [];
      var jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      for (var answer in jsonList) {
        answersList.add(Answers.fromJson(answer));
      }
      return answersList;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<void> discardAllAnswers(
      String email, String code, String scale) async {
    final response = await Api().post(
        "discardAllAnswers",
        jsonEncode(
            <String, dynamic>{'email': email, 'code': code, 'scale': scale}));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<dynamic>> getScore(
      String email, String code, String scale) async {
    final response =
        await Api().get("getScore?email=$email&code=$code&scale=$scale");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<List<Score>> getScoreByWeekApp(String email, String code) async {
    final response =
        await Api().get("getScoreByWeekApp?email=$email&code=$code");
    if (response.statusCode == 200) {
      List<Score> scoreList = [];
      var jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      for (var score in jsonList) {
        scoreList.add(Score.fromJson(score));
      }
      return scoreList;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<String> getFinalMessage(
      String questionnaireCode, int scoreSeverity, bool maxLevel) async {
    final response = await Api().get(
        "getFinalMessage?questionnaireCode=$questionnaireCode&scoreSeverity=$scoreSeverity&maxLevel=$maxLevel");
    if (response.statusCode == 200) {
      return response.body;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}
