import 'package:flutter/material.dart';
import 'package:app_mental/escalas/phq15/phq15.dart';
import 'package:app_mental/escalas/phq15/phq15_result.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';

class Phq15Screen extends StatefulWidget {
  static const routeName = '/phq15-screen';

  @override
  _Phq15ScreenState createState() {
    return _Phq15ScreenState();
  }
}

class _Phq15ScreenState extends State<Phq15Screen> {
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
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(int score, String answer, String scale) {
    QuestionnaireService().addQuestionnaireAnswer(
        userEmail, answer, score, -1, "phq15", _questionIndex, scale);
    setState(() {
      _questionIndex += 1;
    });
  }

  void _resetQuestion() {
    setState(() {
      _questionIndex -= 1;
    });
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
            ? Phq15(
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
                userEmail: _userEmail,
                scale: _userEscala)
            : Phq15Result(
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail),
      ),
    );
  }
}
