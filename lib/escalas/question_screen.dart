import 'package:app_mental/escalas/questionnaireAnswers/promisN1_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/promisN2_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/pset_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/questSD2_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/assist_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/assistN2_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/mdq_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/pcl5_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/phq15_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/promisAnsi_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/psqi_screen.dart';
import 'package:app_mental/escalas/questionnaireAnswers/questSD1_screen.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';
import '../../model/questionnaire_answer.dart';
import './answer_questions.dart';
import './result_questions.dart';

class QuestionScreen extends StatefulWidget {
  static const routeName = '/question-screen';

  @override
  _QuestionScreenState createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  late String userEmail;

  @override
  void initState() {
    getUserEmail();
    super.initState();
  }

  getUserEmail() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((value) {
      setState(() {
        userEmail = value;
      });
    });
  }

  var _questionIndex = 0;

  void _answerQuestion(Object score, int domain, String answer, String scale,
      String questionnaireCode) {
    QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
        email: userEmail,
        answer: answer,
        score: score,
        domain: domain,
        code: questionnaireCode,
        questionIndex: _questionIndex,
        scale: scale);
    QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
    setState(() {
      _questionIndex += 1;
    });
  }

  void _resetQuestion() {
    setState(() {
      _questionIndex -= 1;
    });
  }

  getAnswers(questionnaireCode) {
    switch (questionnaireCode) {
      case ("questSD2"):
        return QuestSD2Screen.answers;
      case ("pn1"):
        return PromisN1Screen.answers;
      case ("pn2"):
        return PromisN2Screen.answers;
      case ("pset"):
        return PsetScreen.answers;
      case ("pcl5"):
        return Pcl5Screen.answers;
      case ("questSD1"):
        return QuestSD1Screen.answers;
      case ("mdq"):
        return MdqScreen.answers;
      case ("pn2A"):
        return PromisAnsiScreen.answers;
      case ("phq15"):
        return Phq15Screen.answers;
      case ("psqi"):
        return PsqiScreen.answers;
      case ("assist"):
        return AssistScreen.answers;
      case ("assistn2"):
        return AssistN2Screen.answers;
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final titleAA = routeArgs['title'];
    final _userEscala = routeArgs["userEscala"];
    final _answeredUntil = routeArgs['answeredUntil'];
    final _userEmail = routeArgs['email'];
    final _questions = routeArgs['questions'];
    final _questionnaireCode = routeArgs['questionnaireCode'];
    var index = _answeredUntil as int;

    if (_questionIndex < index) {
      _questionIndex = index;
    }

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(titleAA!)),
        backgroundColor: kTextColorGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? AnswerQuestions(
                questName: titleAA,
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: getAnswers(_questionnaireCode),
                userEmail: _userEmail,
                scale: _userEscala,
                questionnaireCode: _questionnaireCode)
            : ResultQuestions(
                questionnaireCode: _questionnaireCode,
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail),
      ),
    );
  }
}
