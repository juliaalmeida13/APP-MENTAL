import 'package:app_mental/escalas/psqi/psqi.dart';
import 'package:app_mental/escalas/psqi/psqi_result.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class PsqiScreen extends StatefulWidget {
  static const routeName = '/psqi-screen';

  @override
  _PsqiScreenState createState() {
    return _PsqiScreenState();
  }
}

class _PsqiScreenState extends State<PsqiScreen> {
  static const _questions = [
    {
      'questionText':
          'As seguintes perguntas são relativas aos seus hábitos de sono durante o último mês somente. Suas respostas devem indicar a lembrança mais exata da maioria dos dias e noites do último mês. Por favor, responda a todas as perguntas.',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText':
          'I. Durante o último mês, quando você geralmente foi para a cama à noite?',
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
      'questionText':
          'II. Durante o último mês, quanto tempo você geralmente levou para dormir à noite?',
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
      'questionText':
          'III. Durante o último mês, quando você geralmente levantou de manhã?',
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
      'questionText':
          'IV. Durante o último mês, quantas horas de sono você teve por noite? (Este pode ser diferente do número de horas que você ficou na cama).',
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
      'questionText':
          'V. Durante o último mês, com que freqüência você teve dificuldade de dormir porque você não conseguiu adormecer em até 30 minutos?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'VI. Durante o último mês, com que freqüência você teve dificuldade de dormir porque você acordou no meio da noite ou de manhã cedo?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'VII. Durante o último mês, com que freqüência você teve dificuldade de dormir porque você precisou levantar para ir ao banheiro?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'VIII. Durante o último mês, com que freqüência você teve dificuldade de dormir porque você não conseguiu respirar confortavelmente?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'IX. Durante o último mês, com que freqüência você teve dificuldade de dormir porque você tossiu ou roncou forte?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'X. Durante o último mês, com que freqüência você teve dificuldade de dormir porque você sentiu muito frio?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XI. Durante o último mês, com que freqüência você teve dificuldade de dormir porque você sentiu muito calor?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XII. Durante o último mês, com que freqüência você teve dificuldade de dormir porque você teve sonhos ruins?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XIII. Durante o último mês, com que freqüência você teve dificuldade de dormir porque você teve dor?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XIV. Durante o último mês, com que freqüência você teve dificuldade de dormir por outras razões?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XV. Durante o último mês, como você classificaria a qualidade do seu sono de uma maneira geral?',
      'answers': [
        {'text': 'Muito boa', 'score': 0},
        {'text': 'Boa', 'score': 1},
        {'text': 'Ruim', 'score': 2},
        {'text': 'Muito ruim', 'score': 3},
      ],
    },
    {
      'questionText':
          'XVI. Durante o último mês, com que freqüência você tomou medicamento (prescrito ou “por conta própria”) para lhe ajudar a dormir?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XVII. No último mês, com que freqüência você teve dificuldade de ficar acordado enquanto dirigia, comia ou participava de uma atividade social (festa, reunião de amigos, trabalho, estudo)?',
      'answers': [
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XVIII. Durante o último mês, quão problemático foi para você manter o entusiasmo (ânimo) para fazer as coisas (suas atividades habituais)?',
      'answers': [
        {'text': 'Nenhuma dificuldade', 'score': 0},
        {'text': 'Um problema leve', 'score': 1},
        {'text': 'Um problema razoável', 'score': 2},
        {'text': 'Um grande problema', 'score': 3},
      ],
    },
    {
      'questionText':
          'XIX. Você tem um(a) parceiro [esposo(a)] ou colega de quarto?',
      'answers': [
        {'text': 'Não', 'score': 0},
        {'text': 'Parceiro ou colega', 'score': 1},
        {'text': 'Parceiro no mesmo quarto, mas não na mesma cama', 'score': 2},
        {'text': 'Parceiro na mesma cama', 'score': 3},
      ],
    },
    {
      'questionText':
          'XX. Se você tem um parceiro ou colega de quarto, pergunte a ele/ela com que freqüência, no último mês, você teve ronco forte',
      'answers': [
        {'text': 'Não tenho parceiro/colega de quarto', 'score': 0},
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XXI. Se você tem um parceiro ou colega de quarto, pergunte a ele/ela com que freqüência, no último mês, você teve longas paradas na respiração enquanto dormia',
      'answers': [
        {'text': 'Não tenho parceiro/colega de quarto', 'score': 0},
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XXII. Se você tem um parceiro ou colega de quarto, pergunte a ele/ela com que freqüência, no último mês, você teve contrações ou puxões nas pernas enquanto você dormia',
      'answers': [
        {'text': 'Não tenho parceiro/colega de quarto', 'score': 0},
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XXIII. Se você tem um parceiro ou colega de quarto, pergunte a ele/ela com que freqüência, no último mês, você teve episódios de desorientação ou confusão durante o sono',
      'answers': [
        {'text': 'Não tenho parceiro/colega de quarto', 'score': 0},
        {'text': 'Nenhuma no último mês', 'score': 0},
        {'text': 'Menos de 1 vez/semana', 'score': 1},
        {'text': '1 ou 2 vezes/semana', 'score': 2},
        {'text': '3 ou mais vezes/semana', 'score': 3},
      ],
    },
    {
      'questionText':
          'XXIV. Se você tem um parceiro ou colega de quarto, pergunte a ele/ela com que freqüência, no último mês, você teve outras alterações (inquietações) enquanto você dorme;',
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
  List<dynamic> _totalScoreList = []..length = _questions.length;
  List<Object> _resultOptionList = []..length = _questions.length;

  void _answerQuestion(dynamic score, Object option) {
    _totalScoreList[_questionIndex] = score;
    _resultOptionList[_questionIndex] = option;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print("qIndex : $_questionIndex");
    } else {
      print("questionIndex $_questionIndex > _question.length");
    }
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

    print("psqi_screen: " + _userEmail!);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAA!),
        backgroundColor: kTextColorGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Psqi(
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
            : PsqiResult(
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
