import 'package:flutter/material.dart';
import 'package:app_mental/escalas/phq15/phq15.dart';
import 'package:app_mental/escalas/phq15/phq15_result.dart';

import '../../constants.dart';

class Phq15Screen extends StatefulWidget {
  static const routeName = '/phq15-screen';

  @override
  _Phq15ScreenState createState() {
    return _Phq15ScreenState();
  }
}

class _Phq15ScreenState extends State<Phq15Screen> {
  static const _questions = [
    {
      'questionText':
          'As questões a seguir perguntam sobre problemas que podem tê-lo incomodado nas últimas 4 semanas. Para cada pergunta, escolha o número que melhor descreve o quanto (ou com que frequência) você sentiu-se incomodado por qualquer um dos seguintes problemas.',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText': 'I. Dor de estômago',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'II. Dor nas costas',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'III. Dor nos braços, pernas ou articulações',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText':
          'IV. Cólicas menstruais ou outros problemas durante o período menstrual',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'V. Dor de cabeça',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'VI. Dor no peito',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'VII. Tontura',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'VIII. Desmaios',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'IX. Sentir o coração batendo ou acelerado',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'X. Respiração curta',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'XI. Dor ou problema durante a relação sexual',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'XII. Constipação, intestino solto ou diarréia',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'XIII. Náusea, gases ou indigestão.',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'XIV. Sentindo-se cansado ou com pouco energia',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
    {
      'questionText': 'XV. Problemas de sono',
      'answers': [
        {'text': 'Quase não incomoda', 'score': 0},
        {'text': 'Incomoda um pouco', 'score': 1},
        {'text': 'Incomoda bastante', 'score': 2},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScoreList = List<int>.filled(16, 0);
  var _resultOptionList = List<Object>.filled(16, 0);

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

    print("phq15_screen: " + _userEmail!);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(titleAA!)),
        backgroundColor: kTextColorGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Phq15(
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
            : Phq15Result(
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
