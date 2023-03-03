import 'package:flutter/material.dart';
import 'package:app_mental/escalas/questSD2/questSD2.dart';
import 'package:app_mental/escalas/questSD2/questSD2_result.dart';

import '../../Services/questsService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';

class QuestSD2Screen extends StatefulWidget {
  static const routeName = '/questSD2-screen';

  @override
  _QuestSD2ScreenState createState() {
    return _QuestSD2ScreenState();
  }
}

class _QuestSD2ScreenState extends State<QuestSD2Screen> {
  List<dynamic> _questions = [];
  late String userEmail;

  @override
  void initState() {
    getQuestions();
    getUserEmail();
    super.initState();
  }

  getQuestions() async {
    await QuestsService().getQuestions("questSD2").then((values) {
      values.forEach((value) {
        _questions.add(value);
      });
      setState(
          () {}); //como fazer pra pegar os valores antes de iniciar o estado?
    });
  }

  getUserEmail() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((value) {
      setState(() {
        userEmail = value;
      });
    });
  }

  static const _answers = [
    {
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'contato direto'},
        {'text': 'Não', 'score': 'sem contato direto'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'já teve COVID-19'},
        {'text': 'Não', 'score': 'não teve COVID-19'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'tem intervalos (descanso)'},
        {'text': 'Não', 'score': 'não tem intervalos (descanso)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'tem intervalos (água)'},
        {'text': 'Não', 'score': 'não tem intervalos (água)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'tem intervalos (refeição)'},
        {'text': 'Não', 'score': 'não tem intervalos (refeição)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'Sim (EPI)'},
        {'text': 'Não', 'score': 'Não (EPI)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'Sim (treinamento)'},
        {'text': 'Não', 'score': 'Não (treinamento)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'Sim (atividade/grupo)'},
        {'text': 'Não', 'score': 'Não (atividade/grupo)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'Sim (profissional de saúde mental)'},
        {'text': 'Não', 'score': 'Não (profissional de saúde mental)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'Sim (preconceito)'},
        {'text': 'Não', 'score': 'Não (preconceito)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'Sim (foi afastado)'},
        {'text': 'Não', 'score': 'Não (ser afastado)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'Sim (tratamento)'},
        {'text': 'Não', 'score': 'Não (tratamento)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'Sim (tratamento atual)'},
        {'text': 'Não', 'score': 'Não (tratamento atual)'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'Sim (medicamento)'},
        {'text': 'Não', 'score': 'Não (medicamento)'},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(Object score, Object answer) {
    QuestsService().addQuestionnaireAnswer(
        userEmail, answer, score, -1, "questSD2_week2", _questionIndex);
    setState(() {
      _questionIndex += 1;
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
        title: FittedBox(child: Text(titleAA!)),
        backgroundColor: kTextColorGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? QuestSD2(
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
              )
            : QuestSD2Result(),
      ),
    );
  }
}
