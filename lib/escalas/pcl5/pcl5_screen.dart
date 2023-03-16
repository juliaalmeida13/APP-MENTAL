import 'package:app_mental/constants.dart';
import 'package:app_mental/escalas/answer_questions.dart';
import 'package:app_mental/escalas/result_questions.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';
import '../../helper/constants.dart';
import '../../helper/helperfuncions.dart';

class Pcl5Screen extends StatefulWidget {
  static const routeName = '/pcl5-screen';

  @override
  _Pcl5ScreenState createState() {
    return _Pcl5ScreenState();
  }
}

class _Pcl5ScreenState extends State<Pcl5Screen> {
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
        {'text': 'De modo nenhum', 'score': 0, 'domain': 1},
        {'text': 'Um pouco', 'score': 1, 'domain': 1},
        {'text': 'Moderadamente', 'score': 2, 'domain': 1},
        {'text': 'Muito', 'score': 3, 'domain': 1},
        {'text': 'Extremamente', 'score': 4, 'domain': 1},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 2},
        {'text': 'Um pouco', 'score': 1, 'domain': 2},
        {'text': 'Moderadamente', 'score': 2, 'domain': 2},
        {'text': 'Muito', 'score': 3, 'domain': 2},
        {'text': 'Extremamente', 'score': 4, 'domain': 2},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 3},
        {'text': 'Um pouco', 'score': 1, 'domain': 3},
        {'text': 'Moderadamente', 'score': 2, 'domain': 3},
        {'text': 'Muito', 'score': 3, 'domain': 3},
        {'text': 'Extremamente', 'score': 4, 'domain': 3},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 4},
        {'text': 'Um pouco', 'score': 1, 'domain': 4},
        {'text': 'Moderadamente', 'score': 2, 'domain': 4},
        {'text': 'Muito', 'score': 3, 'domain': 4},
        {'text': 'Extremamente', 'score': 4, 'domain': 4},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 5},
        {'text': 'Um pouco', 'score': 1, 'domain': 5},
        {'text': 'Moderadamente', 'score': 2, 'domain': 5},
        {'text': 'Muito', 'score': 3, 'domain': 5},
        {'text': 'Extremamente', 'score': 4, 'domain': 5},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 6},
        {'text': 'Um pouco', 'score': 1, 'domain': 6},
        {'text': 'Moderadamente', 'score': 2, 'domain': 6},
        {'text': 'Muito', 'score': 3, 'domain': 6},
        {'text': 'Extremamente', 'score': 4, 'domain': 6},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 7},
        {'text': 'Um pouco', 'score': 1, 'domain': 7},
        {'text': 'Moderadamente', 'score': 2, 'domain': 7},
        {'text': 'Muito', 'score': 3, 'domain': 7},
        {'text': 'Extremamente', 'score': 4, 'domain': 7},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 8},
        {'text': 'Um pouco', 'score': 1, 'domain': 8},
        {'text': 'Moderadamente', 'score': 2, 'domain': 8},
        {'text': 'Muito', 'score': 3, 'domain': 8},
        {'text': 'Extremamente', 'score': 4, 'domain': 8},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 9},
        {'text': 'Um pouco', 'score': 1, 'domain': 9},
        {'text': 'Moderadamente', 'score': 2, 'domain': 9},
        {'text': 'Muito', 'score': 3, 'domain': 9},
        {'text': 'Extremamente', 'score': 4, 'domain': 9},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 10},
        {'text': 'Um pouco', 'score': 1, 'domain': 10},
        {'text': 'Moderadamente', 'score': 2, 'domain': 10},
        {'text': 'Muito', 'score': 3, 'domain': 10},
        {'text': 'Extremamente', 'score': 4, 'domain': 10},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 11},
        {'text': 'Um pouco', 'score': 1, 'domain': 11},
        {'text': 'Moderadamente', 'score': 2, 'domain': 11},
        {'text': 'Muito', 'score': 3, 'domain': 11},
        {'text': 'Extremamente', 'score': 4, 'domain': 11},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 12},
        {'text': 'Um pouco', 'score': 1, 'domain': 12},
        {'text': 'Moderadamente', 'score': 2, 'domain': 12},
        {'text': 'Muito', 'score': 3, 'domain': 12},
        {'text': 'Extremamente', 'score': 4, 'domain': 12},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 13},
        {'text': 'Um pouco', 'score': 1, 'domain': 13},
        {'text': 'Moderadamente', 'score': 2, 'domain': 13},
        {'text': 'Muito', 'score': 3, 'domain': 13},
        {'text': 'Extremamente', 'score': 4, 'domain': 13},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 14},
        {'text': 'Um pouco', 'score': 1, 'domain': 14},
        {'text': 'Moderadamente', 'score': 2, 'domain': 14},
        {'text': 'Muito', 'score': 3, 'domain': 14},
        {'text': 'Extremamente', 'score': 4, 'domain': 14},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 15},
        {'text': 'Um pouco', 'score': 1, 'domain': 15},
        {'text': 'Moderadamente', 'score': 2, 'domain': 15},
        {'text': 'Muito', 'score': 3, 'domain': 15},
        {'text': 'Extremamente', 'score': 4, 'domain': 15},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 16},
        {'text': 'Um pouco', 'score': 1, 'domain': 16},
        {'text': 'Moderadamente', 'score': 2, 'domain': 16},
        {'text': 'Muito', 'score': 3, 'domain': 16},
        {'text': 'Extremamente', 'score': 4, 'domain': 16},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 17},
        {'text': 'Um pouco', 'score': 1, 'domain': 17},
        {'text': 'Moderadamente', 'score': 2, 'domain': 17},
        {'text': 'Muito', 'score': 3, 'domain': 17},
        {'text': 'Extremamente', 'score': 4, 'domain': 17},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 18},
        {'text': 'Um pouco', 'score': 1, 'domain': 18},
        {'text': 'Moderadamente', 'score': 2, 'domain': 18},
        {'text': 'Muito', 'score': 3, 'domain': 18},
        {'text': 'Extremamente', 'score': 4, 'domain': 18},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 19},
        {'text': 'Um pouco', 'score': 1, 'domain': 19},
        {'text': 'Moderadamente', 'score': 2, 'domain': 19},
        {'text': 'Muito', 'score': 3, 'domain': 19},
        {'text': 'Extremamente', 'score': 4, 'domain': 19},
      ],
    },
    {
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'domain': 20},
        {'text': 'Um pouco', 'score': 1, 'domain': 20},
        {'text': 'Moderadamente', 'score': 2, 'domain': 20},
        {'text': 'Muito', 'score': 3, 'domain': 20},
        {'text': 'Extremamente', 'score': 4, 'domain': 20},
      ],
    },
  ];

  //(p. ex. analgésicos, estimulantes, sedativos ou tranquilizantes, ou drogas como maconha, cocaína ou crack, drogas sintéticas, alucinógenos, heroína, inalantes ou solventes ou metanfetamina?
  var _questionIndex = 0;

  void _answerQuestion(int score, int domain, String answer, String scale) {
    QuestionnaireService().addQuestionnaireAnswer(userEmail, answer, score,
        domain, QuestionnaireCode.pcl5.name, _questionIndex, scale);
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
        padding: const EdgeInsets.all(30.0),
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
                questionnaireCode: QuestionnaireCode.pcl5.name,
              )
            : ResultQuestions(
                questionnaireCode: QuestionnaireCode.pcl5.name,
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail!),
      ),
    );
  }
}
