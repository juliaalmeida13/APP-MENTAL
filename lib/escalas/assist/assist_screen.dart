import 'package:flutter/material.dart';
import 'package:app_mental/escalas/assist/assist.dart';
import 'package:app_mental/escalas/assist/assist_result.dart';
import '../../constants.dart';

class AssistScreen extends StatefulWidget {
  static const routeName = '/assist-screen';

  @override
  _AssistScreenState createState() {
    return _AssistScreenState();
  }
}

class _AssistScreenState extends State<AssistScreen> {
  static const _questions = [
    {
      'questionText':
          'As questões a seguir perguntam sobre substâncias que você possa ter usado sem prescrição médica durante sua vida. Por favor, responda a cada questão da melhor maneira possível',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText': 'Na sua vida você já usou derivados de tabaco?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText': 'Na sua vida você já bebeu bebidas alcoólicas?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText': 'Na sua vida você já usou maconha sem prescrição médica?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText': 'Na sua vida você já usou cocaína, crack?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Na sua vida você já usou anfetamina ou êxtase sem precrição médica?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText': 'Na sua vida você já usou inalantes?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Na sua vida você já usou hipnóticos ou sedativos sem prescrição médica?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Na sua vida você já usou alucinógenos sem prescrição médica?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Na sua vida você já usou opioides sem prescrição médica?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Na sua vida você já usou outras substâncias sem prescrição médica?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScoreList = List<int>.filled(11, 0);

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
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final titleAA = routeArgs['title'];
    final _userEscala = routeArgs["userEscala"];
    final _answeredUntil = routeArgs['answeredUntil'];
    final _userEmail = routeArgs['email'];
    var index = _answeredUntil as int;

    if (_questionIndex < index) {
      _questionIndex = index;
    }

    print("Mdq_screen: " + _userEmail!);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAA!),
        backgroundColor: kTextColorGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Assist(
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                userEmail: _userEmail,
                resultScoreList: _totalScoreList,
                userEscala: _userEscala!,
                questName: titleAA,
              ) //Quiz
            : AssistResult(
                resultScoreList: _totalScoreList,
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail,
                questionIndex: _questionIndex,
              ),
      ), //Padding
    ); //Scaffold
  }
}
