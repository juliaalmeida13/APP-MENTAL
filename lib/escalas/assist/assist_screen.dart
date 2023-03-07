import 'package:flutter/material.dart';
import 'package:app_mental/escalas/assist/assist.dart';
import 'package:app_mental/escalas/assist/assist_result.dart';
import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';

class AssistScreen extends StatefulWidget {
  static const routeName = '/assist-screen';

  @override
  _AssistScreenState createState() {
    return _AssistScreenState();
  }
}

class _AssistScreenState extends State<AssistScreen> {
  List<dynamic> _questions = [];
  late String userEmail;

  @override
  void initState() {
    getQuestions();
    getUserEmail();
    super.initState();
  }

  getQuestions() async {
    await QuestionnaireService().getQuestions("assist").then((values) {
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
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'answers': [
        {'text': 'Sim, nos últimos 3 meses', 'score': 2},
        {'text': 'Sim, mas não nos últimos 3 meses', 'score': 1},
        {'text': 'Não, nunca', 'score': 0},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(Object score, Object answer, String scale) {
    QuestionnaireService().addQuestionnaireAnswer(
        userEmail, answer, score, -1, "assist", _questionIndex, scale);
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
            ? Assist(
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
                userEmail: _userEmail,
                scale: _userEscala)
            : AssistResult(
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail),
      ),
    );
  }
}
