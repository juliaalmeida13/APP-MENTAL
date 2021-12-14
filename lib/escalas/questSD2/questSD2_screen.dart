import 'package:flutter/material.dart';
import 'package:app_mental/escalas/questSD2/questSD2.dart';
import 'package:app_mental/escalas/questSD2/questSD2_result.dart';

import '../../constants.dart';

class QuestSD2Screen extends StatefulWidget {
  static const routeName = '/questSD2-screen';

  @override
  _QuestSD2ScreenState createState() {
    return _QuestSD2ScreenState();
  }
}

class _QuestSD2ScreenState extends State<QuestSD2Screen> {
  static const _questions = [
    {
      'questionText':
          'As questões a seguir perguntam sobre informações gerais que irão ajudar a eficácia do estudo e a criação de estratégias apropriadas',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText': 'I. Você tem contato direto com pacientes com COVID-19?',
      'answers': [
        {'text': 'Sim', 'score': 'contato direto'},
        {'text': 'Não', 'score': 'sem contato direto'},
      ],
    },
    {
      'questionText': 'II. Você já teve a doença COVID-19?',
      'answers': [
        {'text': 'Sim', 'score': 'já teve COVID-19'},
        {'text': 'Não', 'score': 'não teve COVID-19'},
      ],
    },
    {
      'questionText':
          'III. Durante seu horário de trabalho, você realiza intervalos para descanso?',
      'answers': [
        {'text': 'Sim', 'score': 'tem intervalos (descanso)'},
        {'text': 'Não', 'score': 'não tem intervalos (descanso)'},
      ],
    },
    {
      'questionText':
          'IV. Durante seu horário de trabalho, você realiza intervalos para tomar água?',
      'answers': [
        {'text': 'Sim', 'score': 'tem intervalos (água)'},
        {'text': 'Não', 'score': 'não tem intervalos (água)'},
      ],
    },
    {
      'questionText':
          'V. Durante seu horário de trabalho, você realiza intervalos para se alimentar (almoço, jantar, lanche?',
      'answers': [
        {'text': 'Sim', 'score': 'tem intervalos (refeição)'},
        {'text': 'Não', 'score': 'não tem intervalos (refeição)'},
      ],
    },
    {
      'questionText':
          'VI. A instituição onde trabalha fornece todos os equipamentos de proteção individual que você precisa?',
      'answers': [
        {'text': 'Sim', 'score': 'Sim (EPI)'},
        {'text': 'Não', 'score': 'Não (EPI)'},
      ],
    },
    {
      'questionText':
          'VII. Você recebeu treinamento sobre os protocolos assistenciais do COVID-19?',
      'answers': [
        {'text': 'Sim', 'score': 'Sim (treinamento)'},
        {'text': 'Não', 'score': 'Não (treinamento)'},
      ],
    },
    {
      'questionText':
          'VIII. Na instituição em que trabalha, há alguma atividade/grupo para acolhimento ou prevenção em saúde mental?',
      'answers': [
        {'text': 'Sim', 'score': 'Sim (atividade/grupo)'},
        {'text': 'Não', 'score': 'Não (atividade/grupo)'},
      ],
    },
    {
      'questionText':
          'IX. Na instituição em que trabalha, você tem disponibilidade de algum profissional da saúde mental (psicólogo, psiquiatra, terapeuta ocupacional por exemplo)',
      'answers': [
        {'text': 'Sim', 'score': 'Sim (profissional de saúde mental)'},
        {'text': 'Não', 'score': 'Não (profissional de saúde mental)'},
      ],
    },
    {
      'questionText':
          'X. Durante 2020, sofreu algum tipo de preconceito ou situação de violência por ser profissional de saúde?',
      'answers': [
        {'text': 'Sim', 'score': 'Sim (preconceito)'},
        {'text': 'Não', 'score': 'Não (preconceito)'},
      ],
    },
    {
      'questionText':
          'XI. Durante o ano de 2020, precisou ser afastado do trabalho?',
      'answers': [
        {'text': 'Sim', 'score': 'Sim (foi afastado)'},
        {'text': 'Não', 'score': 'Não (ser afastado)'},
      ],
    },
    {
      'questionText':
          'XII. Você já fez algum tratamento em saúde mental (psicólogo, terapeuta ocupacional, psiquiatra) antes de 2020?',
      'answers': [
        {'text': 'Sim', 'score': 'Sim (tratamento)'},
        {'text': 'Não', 'score': 'Não (tratamento)'},
      ],
    },
    {
      'questionText':
          'XIII. Está fazendo tratamento em saúde mental atualmente?',
      'answers': [
        {'text': 'Sim', 'score': 'Sim (tratamento atual)'},
        {'text': 'Não', 'score': 'Não (tratamento atual)'},
      ],
    },
    {
      'questionText':
          'XIV. Faz uso de algum medicamento psiquiátrico (controlado)?',
      'answers': [
        {'text': 'Sim', 'score': 'Sim (medicamento)'},
        {'text': 'Não', 'score': 'Não (medicamento)'},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScoreList = List<Object>.filled(15, 0);
  var _resultOptionList = List<Object>.filled(15, 0);

  void _answerQuestion(Object score, Object option) {
    _totalScoreList[_questionIndex] = score;
    _resultOptionList[_questionIndex] = option;
    setState(() {
      _questionIndex = _questionIndex + 1;
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
            ? QuestSD2(
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
            : QuestSD2Result(
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
