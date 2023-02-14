import 'package:flutter/material.dart';
import 'package:app_mental/escalas/questSD1/questSD1.dart';
import 'package:app_mental/escalas/questSD1/questSD1_result.dart';

import '../../constants.dart';

class QuestSD1Screen extends StatefulWidget {
  static const routeName = '/questSD1-screen';

  @override
  _QuestSD1ScreenState createState() {
    return _QuestSD1ScreenState();
  }
}

class _QuestSD1ScreenState extends State<QuestSD1Screen> {
  static const _questions = [
    {
      'questionText':
          'As questões a seguir perguntam sobre informações gerais que irão ajudar a eficácia do estudo e a criação de estratégias apropriadas',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText': 'I. Com que gênero você se identifica?',
      'answers': [
        {'text': 'Feminino', 'score': 'F'},
        {'text': 'Masculino', 'score': 'M'},
        {'text': 'Outro', 'score': 'O'},
      ],
    },
    {
      'questionText': 'II. Qual sua idade?',
      'answers': [
        {'text': 'Entre 18 e 25', 'score': '18-25'},
        {'text': 'Entre 26 e 30', 'score': '26-20'},
        {'text': 'Entre 31 e 35', 'score': '31-35'},
        {'text': 'Entre 36 e 40', 'score': '36-40'},
        {'text': 'Entre 41 e 45', 'score': '41-45'},
        {'text': 'Entre 46 e 50', 'score': '46-50'},
        {'text': '51 ou mais', 'score': '51+'},
      ],
    },
    //TO DO marcar mais de uma opção
    {
      'questionText': 'III. Onde você trabalha?',
      'answers': [
        {'text': 'Unidade Básica de Saúde (UBS)', 'score': 'UBS'},
        {'text': 'Unidade de Saúde da Família (USF)', 'score': 'USF'},
        {'text': 'Núcleo de apoio à saúde da família (NASF)', 'score': 'NASF'},
        {'text': 'Consultório na Rua', 'score': 'Consultório na Rua'},
      ],
    },
    {
      'questionText': 'IV. Quantas horas por semana, em média, você trabalha?',
      'answers': [
        {'text': '20 horas/semana', 'score': '20h/semana'},
        {'text': 'Entre 21 a 40 horas/ semanas', 'score': '20-40h/semana'},
        {'text': 'Mais de 40 horas/ semana', 'score': '40+h/semana'},
      ],
    },
    {
      'questionText': 'V. Você trabalha no horário da noite e/ou madrugada?',
      'answers': [
        {'text': 'Sim', 'score': 'trabalha noite/madrugada'},
        {'text': 'Não', 'score': 'não trabalha noite/madrugada'},
      ],
    },
    {
      'questionText': 'VI. Você mora sozinho?(a)',
      'answers': [
        {'text': 'Sim', 'score': 'mora sozinho'},
        {'text': 'Não', 'score': 'não mora sozinho'},
      ],
    },
    {
      'questionText':
          'VII. Você tem filho ou filhos com menos de 18 anos de idade?',
      'answers': [
        {'text': 'Sim', 'score': 'tem filhos -18'},
        {'text': 'Não', 'score': 'Não tem filhos -18'},
      ],
    },
    {
      'questionText': 'VIII. Qual a sua situação conjugal?',
      'answers': [
        {'text': 'Solteiro(a)', 'score': 'Solteiro(a)'},
        {'text': 'Casado(a)', 'score': 'Casado(a)'},
        {'text': 'União Estável', 'score': 'União Estável'},
        {'text': 'Viúvo(a)', 'score': 'Viúvo(a)'},
      ],
    },

    //Overflow de pixel certo
    {
      'questionText': 'IX. Qual sua profissão?',
      'answers': [
        {
          'text': 'Agente comunitário de saúde',
          'score': 'Agente comunitário de saúde'
        },
        {'text': 'Auxiliar de enfermagem', 'score': 'Auxiliar de enfermagem'},
        {'text': 'Técnico de enfermagem', 'score': 'Técnico de enfermagem'},
        {'text': 'Enfermeiro', 'score': 'Enfermeiro'},
        {'text': 'Dentista', 'score': 'Dentista'},
        {'text': 'Médico', 'score': 'Médico'},
        {'text': 'Psicólogo', 'score': 'Psicólogo'},
        {'text': 'Terapeuta ocupacional', 'score': 'Terapeuta ocupacional'},
        {'text': 'Assistente social', 'score': 'Assistente social'},
        {'text': 'Fisioterapeuta', 'score': 'Fisioterapeuta'},
        {'text': 'Fonoaudiólogo', 'score': 'Fonoaudiólogo'},
        {'text': 'Nutricionista', 'score': 'Nutricionista'},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScoreList = List<Object>.filled(24, 0);
  var _resultOptionList = List<Object>.filled(24, 0);

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

    print("QuestSD_screen: " + _userEmail!);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(titleAA!)),
        backgroundColor: kTextColorGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? QuestSD1(
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
            : QuestSD1Result(
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
