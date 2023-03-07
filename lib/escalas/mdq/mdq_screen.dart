import 'package:flutter/material.dart';
import 'package:app_mental/escalas/mdq/mdq.dart';
import 'package:app_mental/escalas/mdq/mdq_result.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';

class MdqScreen extends StatefulWidget {
  static const routeName = '/mdq-screen';

  @override
  _MdqScreenState createState() {
    return _MdqScreenState();
  }
}

class _MdqScreenState extends State<MdqScreen> {
  List<dynamic> _questions = [];
  late String userEmail;

  @override
  void initState() {
    getQuestions();
    getUserEmail();
    super.initState();
  }

  getQuestions() async {
    await QuestionnaireService().getQuestions("mdq").then((values) {
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
  ];

  var _questionIndex = 0;

  void _answerQuestion(Object score, Object answer) {
    QuestionnaireService().addQuestionnaireAnswer(
        userEmail, answer, score, -1, "mdq_week1", _questionIndex);
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
            ? Mdq(
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
                userEmail: _userEmail)
            : MdqResult(
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail),
      ),
    );
  }
}
