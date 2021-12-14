import 'package:flutter/material.dart';
import 'package:app_mental/escalas/assistn2/assistn2.dart';
import 'package:app_mental/escalas/assistn2/assistn2_result.dart';

import '../../constants.dart';

class Assistn2Screen extends StatefulWidget {
  static const routeName = '/assistn2-screen';

  @override
  _Assistn2ScreenState createState() {
    return _Assistn2ScreenState();
  }
}

class _Assistn2ScreenState extends State<Assistn2Screen> {
  static const _questions = [
    {
      'questionText':
          'Por favor, responda a cada questão da melhor maneira possível. As questões a seguir perguntam sobre o seu uso de',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText':
          'Durante os três últimos meses, com que freqüência você utilizou',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': '1 ou 2 vezes', 'score': 2},
        {'text': 'Mensalmente', 'score': 3},
        {'text': 'Semanalmente', 'score': 4},
        {'text': 'Diariamente ou quase todos os dias', 'score': 6},
      ],
    },
    {
      'questionText':
          'Durante os três últimos meses, com que freqüência você teve forte desejo ou urgência em consumir',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': '1 ou 2 vezes', 'score': 3},
        {'text': 'Mensalmente', 'score': 4},
        {'text': 'Semanalmente', 'score': 5},
        {'text': 'Diariamente ou quase todos os dias', 'score': 6},
      ],
    },
    {
      'questionText':
          'Durante os três últimos meses, com que freqüência você enfrentou problema de saúde, legal ou financeiro, resultante do seu consumo de',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': '1 ou 2 vezes', 'score': 4},
        {'text': 'Mensalmente', 'score': 5},
        {'text': 'Semanalmente', 'score': 6},
        {'text': 'Diariamente ou quase todos os dias', 'score': 7},
      ],
    },
    {
      'questionText':
          'Durante os três últimos meses, com que freqüência você deixou de fazer coisas que eram normalmente esperadas de você por causa do seu uso de',
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': '1 ou 2 vezes', 'score': 5},
        {'text': 'Mensalmente', 'score': 6},
        {'text': 'Semanalmente', 'score': 7},
        {'text': 'Diariamente ou quase todos os dias', 'score': 8},
      ],
    },
    {
      'questionText':
          'Há amigos, parentes ou outra pessoa que tenha demonstrado preocupação com seu uso de',
      'answers': [
        {'text': 'Não, nunca', 'score': 0},
        {'text': 'Sim, nos últimos 3 meses', 'score': 6},
        {'text': 'Sim, mas não nos últimos 3 meses', 'score': 3},
      ],
    },
    {
      'questionText':
          'Alguma vez você já tentou controlar, diminuir ou parar sem êxito o uso de',
      'answers': [
        {'text': 'Não, nunca', 'score': 0},
        {'text': 'Sim, nos últimos 3 meses', 'score': 6},
        {'text': 'Sim, mas não nos últimos 3 meses', 'score': 3},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScoreList = List<int>.filled(11, 0);
  var _resultOptionList = List<Object>.filled(11,0);

  void _answerQuestion(int score, Object option) {
    _totalScoreList[_questionIndex] = score;
    _resultOptionList[_questionIndex] = option;
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
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final titleAA = routeArgs['title'];
    final _userEscala = routeArgs["userEscala"];
    final _answeredUntil = routeArgs['answeredUntil'];
    final _userEmail = routeArgs['email'];
    var index = _answeredUntil as int;

    if (_questionIndex < index) {
      _questionIndex = index;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAA!),
        backgroundColor: kTextColorGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Assistn2(
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                userEmail: _userEmail,
                resultScoreList: _totalScoreList,
                resultOptionList: _resultOptionList,
                userEscala: _userEscala!,
                questName: titleAA,
              ) //Quiz
            : Assistn2Result(
                resultScoreList: _totalScoreList,
                resultOptionList: _resultOptionList,
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail,
                questionIndex: _questionIndex,
              ),
      ), //Padding
    ); //Scaffold
  }
}
