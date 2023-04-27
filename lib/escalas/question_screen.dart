import 'package:app_mental/escalas/questionnaireAnswers/promisN1_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/promisN2_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/pset_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/questSD2_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/assist_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/assistN2_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/mdq_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/pcl5_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/phq15_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/promisAnsi_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/psqi_answers.dart';
import 'package:app_mental/escalas/questionnaireAnswers/questSD1_answers.dart';
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
  bool userHasStartedAnswer = false;

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
        return QuestSD2Answers.answers;
      case ("pn1"):
        return PromisN1Answers.answers;
      case ("pn2"):
        return PromisN2Answers.answers;
      case ("pset"):
        return PsetAnswers.answers;
      case ("pcl5"):
        return Pcl5Answers.answers;
      case ("questSD1"):
        return QuestSD1Answers.answers;
      case ("mdq"):
        return MdqAnswers.answers;
      case ("pn2A"):
        return PromisAnsiAnswers.answers;
      case ("phq15"):
        return Phq15Answers.answers;
      case ("psqi"):
        return PsqiAnswers.answers;
      case ("assist"):
        return AssistAnswers.answers;
      case ("assistn2"):
        return AssistN2Answers.answers;
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

    if (_answeredUntil > 0 && _questionIndex == 0 && !userHasStartedAnswer) {
      _questionIndex = _answeredUntil;
      setState(() {
        userHasStartedAnswer = true;
      });
    } else if (_questionIndex < 0) {
      _questionIndex = 0;
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
