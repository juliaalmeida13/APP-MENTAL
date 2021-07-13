import 'package:flutter/material.dart';
import 'package:app_mental/escalas/quesi/quesi.dart';
import 'package:app_mental/escalas/quesi/quesi_result.dart';

import '../../constants.dart';

class QuesiScreen extends StatefulWidget {
  static const routeName = '/quesi-screen';

  @override
  _QuesiScreenState createState() {
    return _QuesiScreenState();
  }
}

class _QuesiScreenState extends State<QuesiScreen> {
  static const _questions = [
    {
      'questionText':
          'A seguir há uma lista de assertativas relacionadas com situações ocorridas na infância e adolescência. Para cada uma, escolha o número que melhor descreve o quanto (ou com que frequência) você experienciou as seguintes situações.',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText': 'I. Eu soube que havia alguém para me cuidar e proteger.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'II. As pessoas da minha família me chamaram de coisas do tipo \"estúpido (a)\", \"preguiçoso (a)\" ou \"feio (a)\".',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'III. Meus pais estiveram muito bêbados ou drogados para poder cuidar da família.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'IV. Houve alguém na minha família que ajudou a me sentir especial ou importante.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText': 'V. Eu me senti amado (a).',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'VI. Eu achei que meus pais preferiam que eu nunca tivesse nascido.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'VII. As pessoas da minha família cuidavam umas das outras.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText': 'VIII. Eu tive uma ótima infância.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText': 'IX. Eu senti que alguém da minha família me odiava.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText': 'X. As pessoas da minha família se sentiam unidas.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText': 'XI. Eu acredito que fui maltratado (a) emocionalmente.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText': 'XII. Minha família foi uma fonte de força e apoio',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'XIII. Tentaram me tocar ou me fizeram tocar de uma maneira sexual.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText': 'XIV. Alguém me molestou.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'XV. Tentaram me forçar a fazer algo sexual ou assistir coisas sobre sexo.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'XVI. Ameaçaram me machucar ou contar mentiras sobre mim se eu não fizesse algo sexual.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText': 'XVII. Eu acredito que fui abusado (a) sexualmente.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'XVIII. Eu apanhei tanto que um professor, vizinho ou médico chegou a notar.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'XIX. Eu apanhei tanto que um professor, vizinho ou médico chegou a notar.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText': 'XX. Eu acredito que fui maltratado (a) fisicamente.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
    {
      'questionText':
          'XXI. Alguém da minha família me bateu tanto que me deixou com machucados roxos.',
      'answers': [
        {'text': 'Nunca ocorreu', 'score': 1},
        {'text': 'Ocorreu poucas vezes', 'score': 2},
        {'text': 'Ocorreu às vezes', 'score': 3},
        {'text': 'Ocorreu muitas vezes', 'score': 4},
        {'text': 'Ocorreu sempre', 'score': 5},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScoreList = List<int>.filled(22, 0);

  void _answerQuestion(int score) {
    _totalScoreList[_questionIndex] = score;
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

    print("Quesi_screen: " + _userEmail!);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAA!),
        backgroundColor: kTextColorGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Quesi(
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                userEmail: _userEmail,
                resultScoreList: _totalScoreList,
                userEscala: _userEscala!,
                questName: titleAA,
              ) //Quiz
            : QuesiResult(
                resultScoreList: _totalScoreList,
                questName: titleAA,
                userEscala: _userEscala!,
                userEmail: _userEmail,
                questionIndex: _questionIndex,
              ),
      ), //Padding
    ); //Scaffold
  }
}
