import 'package:app_mental/escalas/psqi/psqi.dart';
import 'package:app_mental/escalas/psqi/psqi_result.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';

class PsqiScreen extends StatefulWidget {
  static const routeName = '/psqi-screen';

  @override
  _PsqiScreenState createState() {
    return _PsqiScreenState();
  }
}

class _PsqiScreenState extends State<PsqiScreen> {
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
      'type': "time",
      'answers': [
        {'text': 'Antes de 20:00 h', 'score': 0},
        {'text': 'Entre 20:00 h e 20:59 h', 'score': 1},
        {'text': 'Entre 21:00 h e 21:59 h', 'score': 2},
        {'text': 'Entre 22:00 h e 22:59 h', 'score': 3},
        {'text': 'Entre 23:00 h e 23:59 h', 'score': 4},
        {'text': 'Depois de 23:59 h', 'score': 5},
      ],
    },
    {
      'type': "time",
      'answers': [
        {'text': 'Menos de 5 minutos', 'score': 0},
        {'text': 'Entre 6 e 15 minutos', 'score': 1},
        {'text': 'Entre 16 e 30 minutos ', 'score': 2},
        {'text': 'Entre 31 e 45 minutos', 'score': 3},
        {'text': 'Entre 46 e 59 minutos', 'score': 4},
        {'text': '1 hora ou mais', 'score': 5}
      ],
    },
    {
      'type': "time",
      'answers': [
        {'text': 'Antes de 05:00 h', 'score': 0},
        {'text': 'Entre 05:00 h e 5:59 h', 'score': 1},
        {'text': 'Entre 06:00 h e 06:59 h', 'score': 2},
        {'text': 'Entre 07:00 h e 07:59 h', 'score': 3},
        {'text': 'Entre 08:00 h e 08:59 h', 'score': 4},
        {'text': '09:00 h ou depois', 'score': 5}
      ],
    },
    {
      'type': "time",
      'answers': [
        {'text': 'Menos de 4 horas', 'score': 0},
        {'text': 'Entre 4 e 5 horas', 'score': 1},
        {'text': 'Entre 5 e 6 horas', 'score': 2},
        {'text': 'Entre 6 e 7 horas', 'score': 3},
        {'text': 'Entre 8 e 9 horas', 'score': 4},
        {'text': '9 hora ou mais', 'score': 5}
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Muito boa', 'score': 0},
        {'text': 'Boa', 'score': 1},
        {'text': 'Ruim', 'score': 2},
        {'text': 'Muito ruim', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Nenhuma dificuldade', 'score': 0},
        {'text': 'Um problema leve', 'score': 1},
        {'text': 'Um problema razoável', 'score': 2},
        {'text': 'Um grande problema', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Não', 'score': 0},
        {'text': 'Parceiro ou colega', 'score': 1},
        {'text': 'Parceiro no mesmo quarto, mas não na mesma cama', 'score': 2},
        {'text': 'Parceiro na mesma cama', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Não tenho parceiro/colega de quarto', 'score': 0},
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Não tenho parceiro/colega de quarto', 'score': 0},
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Não tenho parceiro/colega de quarto', 'score': 0},
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Não tenho parceiro/colega de quarto', 'score': 0},
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'answers': [
        {'text': 'Não tenho parceiro/colega de quarto', 'score': 0},
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(int score, String answer, String scale) {
    QuestionnaireService().addQuestionnaireAnswer(
        userEmail, answer, score, -1, "psqi", _questionIndex, scale);
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
            ? Psqi(
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
                userEmail: _userEmail,
                scale: _userEscala)
            : PsqiResult(
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail),
      ),
    );
  }
}
