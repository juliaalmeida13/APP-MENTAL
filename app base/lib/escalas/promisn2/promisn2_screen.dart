import 'package:flutter/material.dart';
//import 'fancy_button.dart'
import 'package:chat_app_tutorial/escalas/promisn2/promisn2.dart';
import 'package:chat_app_tutorial/escalas/promisn2/promisn2_result.dart';

class Promisn2Screen extends StatefulWidget {
  static const routeName = '/promisn2-screen';

  @override
  _Promisn2ScreenState createState() {
    return _Promisn2ScreenState();
  }
}

class _Promisn2ScreenState extends State<Promisn2Screen> {
  static const _questions = [
    {
      'questionText':
          'As questões a seguir perguntam sobre coisas que podem tê-lo pertubado nestes últimos sete (7) dias. Para cada pergunta, escolha o número que melhor descreve o quanto (ou com que frequência) você foi perturbado pelos problemas descritos a seguir.',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText':
          'I. Senti-me sem valor e sem importância (inútil para as pessoas)',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'II. Senti que eu não tinha expectativas para o futuro',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'III. Senti-me incapaz',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'IV. Senti-me triste',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'V. Senti-me um fracassado(a)',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'VI. Senti-me deprimido(a)',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'VII. Senti-me infeliz',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'VIII. Senti-me sem esperança',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
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
    final _userEscala = routeArgs["userEscala"];
    final _answeredUntil = routeArgs['answeredUntil'];
    final _userEmail = routeArgs['email'];
    var index = _answeredUntil as int;

    if (_questionIndex < index) {
      _questionIndex = index;
    }

    print("Promisn2_screen: " + _userEmail);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAA),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Promisn2(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                userEmail: _userEmail,
                resultScore: _totalScore,
                userEscala: _userEscala,
                questName: titleAA,
              ) //Quiz
            : Promisn2Result(
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
