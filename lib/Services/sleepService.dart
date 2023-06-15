import 'dart:convert';

import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:app_mental/model/sleep_diary.dart';

import 'api.dart';

class SleepService {
  Future<void> addNewSleepDiary(String userEmail, Map answerQuestions) async {
    final response = await Api().post(
        "addAnswerSleepQuestionnaire",
        jsonEncode(<String, String>{
          'userEmail': userEmail,
          'gotoBed': answerQuestions['resp1'],
          'tryToSleep': answerQuestions['resp2'],
          'whileToSleep': answerQuestions['resp3'],
          'timesWokeUp': answerQuestions['resp4'],
          'timeAwake': answerQuestions['resp5'],
          'wakeUpTime': answerQuestions['resp6'],
          'spendInBed': answerQuestions['resp7'],
          'sleepDuringDay': answerQuestions['resp8'],
        }));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<bool> isSleepDiaryAnsweredToday(String userEmail) async {
    final response =
        await Api().get("isAnsweredSleepQuestionnaireToday?email=$userEmail");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<SleepDiary> getSleepQuestionnaireAnswersApp(
      String email, String createdAt) async {
    final response = await Api().get(
        "getSleepQuestionnaireAnswersApp?email=$email&createdAt=$createdAt");
    if (response.statusCode == 200) {
      return SleepDiary.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<List<DateTime>> getSleepQuestionnaireDates(String email) async {
    final response = await Api().get("getSleepQuestionnaireDates?email=$email");
    if (response.statusCode == 200) {
      List<DateTime> dateTimeList = [];
      var jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      for (var date in jsonList) {
        dateTimeList.add(DateTime(int.parse(date.substring(0, 4)),
            int.parse(date.substring(5, 7)), int.parse(date.substring(8, 10))));
      }
      return dateTimeList;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}
