import 'package:app_mental/constants.dart';
import 'package:app_mental/escalas/answer_questions.dart';
import 'package:app_mental/escalas/result_questions.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';
import '../../helper/constants.dart';
import '../../helper/helperfuncions.dart';

class PromisN1Screen extends StatefulWidget {
  static const routeName = '/promisn1-screen';

  @override
  _PromisN1ScreenState createState() {
    return _PromisN1ScreenState();
  }
}

class _PromisN1ScreenState extends State<PromisN1Screen> {
  late String userEmail;

  @override
  void initState() {
    getUserEmail();
    super.initState();
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
        {'text': 'Entendi e quero prosseguir', 'score': 0, 'domain': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 1},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 1
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 1},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 1},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 1},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 1},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 1
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 1},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 1},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 1},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 2},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 2
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 2},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 2},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 2},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 3},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 3
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 3},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 3},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 3
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 3},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 4},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 4
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 4},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 4},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 4},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 4
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 4},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 4},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 4},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 4
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 4},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 4},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 5},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 5
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 5},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 5},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 5},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 5},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 5
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 5},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 5},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 5},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 6},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 6
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 6},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 6},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 6},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 7},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 7
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 7},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 7},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 7},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 7},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 7
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 7},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 7},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 7},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 8},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 8
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 8},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 8},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 8},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 9},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 9
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 9},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 9},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 9},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 10},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 10
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 10},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 10},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 10},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 10},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 10
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 10},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 10},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 10},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 11},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 11
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 11},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 11},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 11},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 12},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 12
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 12},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 12},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 12},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 12},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 12
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 12},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 12},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 12},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 13},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 13
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 13},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 13},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 13},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 13},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 13
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 13},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 13},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 13},
      ],
    },
    {
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'domain': 13},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'domain': 13
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'domain': 13},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'domain': 13},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'domain': 13},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(int score, int domain, String answer, String scale) {
    QuestionnaireService().addQuestionnaireAnswer(userEmail, answer, score,
        domain, QuestionnaireCode.pn1.name, _questionIndex, scale);
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
    final _userEscala = routeArgs['userEscala'];
    final _answeredUntil = routeArgs['answeredUntil'];
    final _userEmail = routeArgs['email'];
    final _questions = routeArgs['questions'];
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
            ? AnswerQuestions(
                questName: titleAA,
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
                userEmail: _userEmail,
                scale: _userEscala,
                questionnaireCode: QuestionnaireCode.pn1.name)
            : ResultQuestions(
                questionnaireCode: QuestionnaireCode.pn1.name,
                userEmail: _userEmail,
                questName: titleAA,
                userEscala: _userEscala!,
              ),
      ),
    );
  }
}
