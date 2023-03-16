import 'package:app_mental/escalas/answer_questions.dart';
import 'package:app_mental/escalas/result_questions.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/constants.dart';
import '../../helper/helperfuncions.dart';

class PsetScreen extends StatefulWidget {
  static const routeName = '/pset-screen';

  @override
  _PsetScreenState createState() {
    return _PsetScreenState();
  }
}

class _PsetScreenState extends State<PsetScreen> {
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

  static const _answers = [
    {
      'answers': [
        {'text': 'Não', 'score': 0},
        {'text': 'Sim', 'score': 1},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(int score, String answer, String scale) {
    QuestionnaireService().addQuestionnaireAnswer(userEmail, answer, score, -1,
        QuestionnaireCode.pset.name, _questionIndex, scale);
    setState(() {
      _questionIndex += 1;
    });
  }

  void _resetQuestion() {}

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final titleAA = routeArgs['title'];
    final _userEscala = routeArgs['userEscala'];
    final _answeredUntil = routeArgs['answeredUntil'];
    final _userEmail = routeArgs['email'];
    final _questions = routeArgs['questions'];
    var index = _answeredUntil as int;

    if (_questionIndex < index) {
      _questionIndex = index;
    }

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(titleAA!)),
        backgroundColor: kTextColorGreen,
      ),
      body: Container(
        padding: const EdgeInsets.all(50.0),
        child: _questionIndex < _questions.length
            ? AnswerQuestions(
                questName: titleAA,
                sizeQuestionnaire: _questions.length - 1,
                resetQuestion: _resetQuestion,
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
                userEmail: _userEmail!,
                scale: _userEscala,
                questionnaireCode: QuestionnaireCode.pset.name,
              )
            : ResultQuestions(
                questionnaireCode: QuestionnaireCode.pset.name,
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail!),
      ),
    );
  }
}
