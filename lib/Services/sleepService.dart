import 'dart:convert';

import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String url = dotenv.env['BACKEND_URL']!;

class SleepService {
  Future<void> addNewSleepDiary(String userEmail, Map answerQuestions) async {
    final response =
        await http.post(Uri.parse("${url}addAnswerSleepQuestionnaire"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
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
    final response = await http.get(
      Uri.parse("${url}isAnsweredSleepQuestionnaireToday?email=$userEmail"),
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
}
