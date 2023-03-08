import 'package:flutter/material.dart';
import 'package:app_mental/escalas/assistn2/assistn2.dart';
import 'package:app_mental/escalas/assistn2/assistn2_result.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';

class Assistn2Screen extends StatefulWidget {
  static const routeName = '/assistn2-screen';

  @override
  _Assistn2ScreenState createState() {
    return _Assistn2ScreenState();
  }
}

class _Assistn2ScreenState extends State<Assistn2Screen> {
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
        {'text': 'Nunca', 'score': 0},
        {'text': '1 ou 2 vezes', 'score': 2},
        {'text': 'Mensalmente', 'score': 3},
        {'text': 'Semanalmente', 'score': 4},
        {'text': 'Diariamente ou quase todos os dias', 'score': 6},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': '1 ou 2 vezes', 'score': 3},
        {'text': 'Mensalmente', 'score': 4},
        {'text': 'Semanalmente', 'score': 5},
        {'text': 'Diariamente ou quase todos os dias', 'score': 6},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': '1 ou 2 vezes', 'score': 4},
        {'text': 'Mensalmente', 'score': 5},
        {'text': 'Semanalmente', 'score': 6},
        {'text': 'Diariamente ou quase todos os dias', 'score': 7},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': '1 ou 2 vezes', 'score': 5},
        {'text': 'Mensalmente', 'score': 6},
        {'text': 'Semanalmente', 'score': 7},
        {'text': 'Diariamente ou quase todos os dias', 'score': 8},
      ],
    },
    {
      'answers': [
        {'text': 'Não, nunca', 'score': 0},
        {'text': 'Sim, nos últimos 3 meses', 'score': 6},
        {'text': 'Sim, mas não nos últimos 3 meses', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Não, nunca', 'score': 0},
        {'text': 'Sim, nos últimos 3 meses', 'score': 6},
        {'text': 'Sim, mas não nos últimos 3 meses', 'score': 3},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(Object score, Object answer, String scale) {
    QuestionnaireService().addQuestionnaireAnswer(
        userEmail, answer, score, -1, "assistn2", _questionIndex, scale);
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
            ? Assistn2(
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
                userEmail: _userEmail,
                questName: titleAA,
                scale: _userEscala)
            : Assistn2Result(
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail),
      ),
    );
  }
}
