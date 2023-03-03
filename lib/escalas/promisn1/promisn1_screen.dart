//import 'fancy_button.dart'
import 'package:app_mental/constants.dart';
import 'package:app_mental/escalas/promisn1/promisn1.dart';
import 'package:app_mental/escalas/promisn1/promisn1_result.dart';
import 'package:flutter/material.dart';

import '../../Services/questsService.dart';
import '../../helper/helperfuncions.dart';

class Promisn1Screen extends StatefulWidget {
  static const routeName = '/promisn1-screen';

  @override
  _Promisn1ScreenState createState() {
    return _Promisn1ScreenState();
  }
}

class _Promisn1ScreenState extends State<Promisn1Screen> {
  List<dynamic> _questions = [];
  late String userEmail;

  @override
  void initState() {
    getQuestions();
    getUserEmail();
    super.initState();
  }

  getQuestions() async {
    await QuestsService().getQuestions("pn1").then((values) {
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
        {'text': 'Entendi e quero prosseguir', 'score': 0, 'dom': 0},
      ],
    },
    {
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
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 4},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 4
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 4},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 4},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 4},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 4
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 4},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 4},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 4},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 4
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 4},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 4},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 5},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 5
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 5},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 5},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 5},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 5},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 5
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 5},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 5},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 5},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 6},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 6
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 6},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 6},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 6},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 7},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 7
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 7},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 7},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 7},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 7},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 7
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 7},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 7},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 7},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 8},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 8
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 8},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 8},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 8},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 9},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 9
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 9},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 9},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 9},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 10},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 10
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 10},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 10},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 10},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 10},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 10
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 10},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 10},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 10},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 11},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 11
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 11},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 11},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 11},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 12},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 12
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 12},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 12},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 12},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 12},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 12
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 12},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 12},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 12},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 13},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 13
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 13},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 13},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 13},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 13},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 13
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 13},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 13},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 13},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 13},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 13
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 13},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 13},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 13},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(Object score, int dom, Object answer) {
    QuestsService().addQuestionnaireAnswer(
        userEmail, answer, score, dom, "promisN1_week1", _questionIndex);
    setState(() {
      _questionIndex += 1;
    });
  }

  void _resetLastDomain() {
    setState(() {
      _questionIndex -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final titleAA = routeArgs['title'];
    final _userEscala = routeArgs['userEscala'];
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
        padding: const EdgeInsets.all(20.0),
        child: _questionIndex < _questions.length
            ? Promisn1(
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetLastDomain: _resetLastDomain,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
                userEmail: _userEmail)
            : Promisn1Result(
                userEmail: _userEmail,
                questName: titleAA,
                userEscala: _userEscala!,
              ),
      ),
    );
  }
}
