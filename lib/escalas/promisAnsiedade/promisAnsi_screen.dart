import 'package:app_mental/escalas/answer_questions.dart';
import 'package:app_mental/escalas/result_questions.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/constants.dart';
import '../../helper/helperfuncions.dart';

class PromisAnsiScreen extends StatefulWidget {
  static const routeName = '/promisAnsi-screen';

  @override
  _PromisAnsiScreenState createState() {
    return _PromisAnsiScreenState();
  }
}

class _PromisAnsiScreenState extends State<PromisAnsiScreen> {
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
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
    {
      'answers': [
        {'text': 'Nunca', 'score': 0},
        {'text': 'Raramente', 'score': 1},
        {'text': 'Às vezes', 'score': 2},
        {'text': 'Frequentemente', 'score': 3},
        {'text': 'Sempre', 'score': 4},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(int score, String answer, String scale) {
    QuestionnaireService().addQuestionnaireAnswer(userEmail, answer, score, -1,
        QuestionnaireCode.pn2A.name, _questionIndex, scale);
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
                questionnaireCode: QuestionnaireCode.pn2A.name)
            : ResultQuestions(
                questionnaireCode: QuestionnaireCode.pn2A.name,
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail),
      ),
    );
  }
}
