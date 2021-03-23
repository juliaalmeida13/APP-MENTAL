import 'package:flutter/material.dart';
//import 'fancy_button.dart'
import './quiz.dart';
import './result.dart';

class QuestScreen extends StatefulWidget {
  @override
  _QuestScreenState createState() {
    return _QuestScreenState();
  }
}

class _QuestScreenState extends State<QuestScreen> {
  static const _questions = [
    {
      'questionText': 'I. 1. Pouco Interesse ou prazer em fazer as coisas?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0},
        {'text': 'Muito leve. Raramente, menos de um ou dois dias', 'score': 1},
        {'text': 'Leve. Vários dias', 'score': 2},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4},
      ],
    },
    {
      'questionText': 'I. 2. Sentiu-se desanimado, deprimido ou sem esperança?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0},
        {'text': 'Muito leve. Raramente, menos de um ou dois dias', 'score': 1},
        {'text': 'Leve. Vários dias', 'score': 2},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4},
      ],
    },
    {
      'questionText':
          ' II. 3. Sentiu-se mais irritado, mal humorado ou zangado do que o usual?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0},
        {'text': 'Muito leve. Raramente, menos de um ou dois dias', 'score': 1},
        {'text': 'Leve. Vários dias', 'score': 2},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4},
      ],
    },
    {
      'questionText':
          'III. 4. Dormiu menos que o usual mas ainda tem muita energia?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0},
        {'text': 'Muito leve. Raramente, menos de um ou dois dias', 'score': 1},
        {'text': 'Leve. Vários dias', 'score': 2},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4},
      ],
    },
    {
      'questionText':
          'III. 5. Iniciou muito mais projetos do que o usual ou fez coisas mais arriscadas do que o habitual?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0},
        {'text': 'Muito leve. Raramente, menos de um ou dois dias', 'score': 1},
        {'text': 'Leve. Vários dias', 'score': 2},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4},
      ],
    },
  ];
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
  }
*/
  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print('ahn');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Escala Teste'),
          backgroundColor: Colors.lightGreenAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                ) //Quiz
              : Result(_totalScore),
        ), //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    );
  }
}
