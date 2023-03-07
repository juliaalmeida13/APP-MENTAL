import 'package:flutter/material.dart';
import 'package:app_mental/escalas/pset/pset.dart';
import 'package:app_mental/escalas/pset/pset_result.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';

class PsetScreen extends StatefulWidget {
  static const routeName = '/pset-screen';

  @override
  _PsetScreenState createState() {
    return _PsetScreenState();
  }
}

class _PsetScreenState extends State<PsetScreen> {
  List<dynamic> _questions = [];
  late String userEmail;

  @override
  void initState() {
    getQuestions();
    getUserEmail();
    super.initState();
  }

  getQuestions() async {
    await QuestionnaireService().getQuestions("pset").then((values) {
      values.forEach((value) {
        _questions.add(value);
      });
      setState(
          () {}); //como fazer pra pegar os valores antes de iniciar o estado?
    });
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

  void _answerQuestion(Object score, Object answer, String scale) {
    QuestionnaireService().addQuestionnaireAnswer(
        userEmail, answer, score, -1, "pset", _questionIndex, scale);
    setState(() {
      _questionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final titleAA = routeArgs['title'];
    final _userEscala = routeArgs['userEscala'];
    final _answeredUntil = routeArgs['answeredUntil'];
    final _userEmail = routeArgs['email'];
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
            ? Pset(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
                userEmail: _userEmail!,
                scale: _userEscala)
            : PsetResult(
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail!),
      ),
    );
  }
}
