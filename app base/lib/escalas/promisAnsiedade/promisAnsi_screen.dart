import 'package:flutter/material.dart';
import 'package:chat_app_tutorial/escalas/promisAnsiedade/promisAnsi.dart';
import 'package:chat_app_tutorial/escalas/promisAnsiedade/promisAnsi_result.dart';

class PromisAnsiScreen extends StatefulWidget {
  static const routeName = '/promisAnsi-screen';

  @override
  _PromisAnsiScreenState createState() {
    return _PromisAnsiScreenState();
  }
}

class _PromisAnsiScreenState extends State<PromisAnsiScreen> {
  static const _questions = [
    {
      'questionText':
          'As questões a seguir visam obter informações sobre a freqüência que você tem sido incomodado por uma lista de \“sentimentos negativos\” durante a última semana. Para cada pergunta, escolha o número que melhor descreve o quanto (ou com que frequência) você tem sido incomodado pelos "sentimentos negativos" descritos a seguir.',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText': 'I. Eu me senti apreensivo (a).',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'II. Eu me senti ansioso (a).',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'III. Eu me senti preocupado (a).',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText':
          'IV. Achei difícil me concentrar em qualquer coisa a não ser na minha ansiedade.',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'V. Eu me senti nervoso (a).',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'VI. Eu me senti inquieto (a).',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'questionText': 'VII. Eu me senti tenso (a).',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScoreList = List<int>.filled(8, 0);

  void _answerQuestion(int score) {
    _totalScoreList[_questionIndex] = score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print("qIndex : $_questionIndex");
    } else {
      print("questionIndex $_questionIndex > _question.length");
    }
  }

  void _resetQuestion() {
    setState(() {
      _questionIndex -= 1;
    });
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

    print("PromisAnsi_screen: " + _userEmail);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAA),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? PromisAnsi(
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                userEmail: _userEmail,
                resultScoreList: _totalScoreList,
                userEscala: _userEscala,
                questName: titleAA,
              ) //Quiz
            : PromisAnsiResult(
                resultScoreList: _totalScoreList,
                questName: titleAA,
                userEscala: _userEscala,
                userEmail: _userEmail,
                questionIndex: _questionIndex,
              ),
      ), //Padding
    ); //Scaffold
  }
}
