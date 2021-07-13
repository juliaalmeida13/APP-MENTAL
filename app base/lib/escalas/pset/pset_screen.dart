import 'package:flutter/material.dart';

//import 'fancy_button.dart'
import 'package:chat_app_tutorial/escalas/pset/pset.dart';
import 'package:chat_app_tutorial/escalas/pset/pset_result.dart';

class PsetScreen extends StatefulWidget {
  static const routeName = '/pset-screen';

  @override
  _PsetScreenState createState() {
    return _PsetScreenState();
  }
}

class _PsetScreenState extends State<PsetScreen> {
  static const _questions = [
    {
      'questionText':
          'Neste último mês você passou por uma experiência muito estressante envolvendo morte ou ameaça de morte, ferimentos graves ou violência sexual que aconteceu diretamente com você, ou que você testemunhou, ou que você ficou sabendo ter acontecido com um familiar próximo ou amigo próximo?',
      'answers': [
        {'text': 'Não', 'score': 0},
        {'text': 'Sim', 'score': 1},
      ],
    },
  ];

  //(p. ex. analgésicos, estimulantes, sedativos ou tranquilizantes, ou drogas como maconha, cocaína ou crack, drogas sintéticas, alucinógenos, heroína, inalantes ou solventes ou metanfetamina?
  var _questionIndex = 0;
  var _totalScore = 0;

  /*void _resetQuiz(BuildContext ctx) {
    _questionIndex = 0;
    _totalScore = 0;
    Navigator.of(ctx).pop();
    /*setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    }); */
*/
  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print("qIndex : $_questionIndex");
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
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
        title: Text(titleAA),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(50.0),
        child: _questionIndex < _questions.length
            ? Pset(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                userEmail: _userEmail,
                resultScore: _totalScore,
                userEscala: _userEscala,
                questName: titleAA,
              ) //Quiz
            : PsetResult(
                resultScore: _totalScore,
                questName: titleAA,
                userEscala: _userEscala,
                userEmail: _userEmail,
                questionIndex: _questionIndex,
              ),
      ), //Padding
    ); //Scaffold
    // debugShowCheckedModeBanner: false,;
  }
}
