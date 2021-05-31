import 'package:flutter/material.dart';
//import 'fancy_button.dart'
import './promisn1.dart';
import '../result.dart';

class Promisn1Screen extends StatefulWidget {
  static const routeName = '/promisn1-screen';

  @override
  _Promisn1ScreenState createState() {
    return _Promisn1ScreenState();
  }
}

class _Promisn1ScreenState extends State<Promisn1Screen> {
  static const _questions = [
    {
      'questionText': 'I. 1. Pouco Interesse ou prazer em fazer as coisas?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 1},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 1
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 1},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 1},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 1},
      ],
    },
    {
      'questionText': 'I. 2. Sentiu-se desanimado, deprimido ou sem esperança?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 1},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 1
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 1},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 1},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 1},
      ],
    },
    {
      'questionText':
          ' II. 3. Sentiu-se mais irritado, mal humorado ou zangado do que o usual?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 2},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 2
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 2},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 2},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 2},
      ],
    },
    {
      'questionText':
          'III. 4. Dormiu menos que o usual mas ainda tem muita energia?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 3},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 3
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 3},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 3},
      ],
    },
    {
      'questionText':
          'III. 5. Iniciou muito mais projetos do que o usual ou fez coisas mais arriscadas do que o habitual?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 3},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 3
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 3},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 3},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScoreList = List<int>.filled(13, 0);

  /*void _resetQuiz(BuildContext ctx) {
    _questionIndex = 0;
    _totalScore = 0;
    Navigator.of(ctx).pop();
    /*setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    }); */
*/
  void _answerQuestion(int score, int domin) {
    _totalScoreList[domin] += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print('ahn');
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final titleAA = routeArgs['title'];
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAA),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Promisn1(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              ) //Quiz
            : Promisn1Result(resultScoreList: _totalScoreList),
      ), //Padding
    ); //Scaffold
    // debugShowCheckedModeBanner: false,;
  }
}
