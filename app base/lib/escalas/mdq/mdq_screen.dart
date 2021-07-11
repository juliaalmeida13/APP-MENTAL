import 'package:flutter/material.dart';
import 'package:chat_app_tutorial/escalas/mdq/mdq.dart';
import 'package:chat_app_tutorial/escalas/mdq/mdq_result.dart';

class MdqScreen extends StatefulWidget {
  static const routeName = '/mdq-screen';

  @override
  _MdqScreenState createState() {
    return _MdqScreenState();
  }
}

class _MdqScreenState extends State<MdqScreen> {
  static const _questions = [
    {
      'questionText':
          'A seguir há uma série de questões que iniciam com \"Alguma vez você não esteve no seu estado normal durante um período e...\". Por favor, responda a cada questão da melhor maniera possível.',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você se sentiu tão bem ou tão para cima que outras pessoas pensaram que você não estava no seu estado normal ou você estava com tanta energia que se meteu em dificuldades?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você ficou tão irritado que gritou com outras pessoas ou começou brigas ou discussões?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você se sentiu muito mais autoconfiante do que se sente normalmente?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você dormiu muito menos que o normal e achou que realmente não fez falta?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você estava muito mais falante ou falou muito mais rápido do que fala normalmente?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e os pensamentos passavam rapidamente na sua cabeça ou você não conseguia desacelerar sua mente? ',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você se distraía tão facilmente com as coisas a seu redor que tinha dificuldade de se concentrar ou de manter o foco?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você ficou muito mais ativo ou fez muito mais coisas do que faz normalmente?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você ficou muito mais sociável ou expansivo do que é normalmente, por exemplo, você telefonou para amigos no meio da noite?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você ficou muito mais interessado em sexo do que normalmente?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          '11Alguma vez você não esteve no seu estado normal durante um período e você teve muito mais energia do que tem normalmente?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e você fez coisas que não costumava fazer ou que outras pessoas podem ter achado que eram excessivas, tolas ou arriscadas?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Alguma vez você não esteve no seu estado normal durante um período e gastou dinheiro a ponto de deixar você ou sua família em apuros?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Se você marcou SIM mais de uma vez nas questões acima, já aconteceu que algumas delas aconteceram numa mesma época?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Quanto foi que qualquer uma delas causou um problema para você, por exemplo, de não conseguir trabalhar, ter dificuldades familiares, de dinheiro ou legais, de entrar em discussões ou brigas?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Algum parente consangüíneo (por exemplo, filhos, irmãos, pais, avós, tios, tias) teve doença maníaco-depressiva ou transtorno bipolar?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
    {
      'questionText':
          'Algum profisional de saúde alguma vez lhe disse que você tinha doença maníaco-depressiva ou transtorno bipolar?',
      'answers': [
        {'text': 'Sim', 'score': 1},
        {'text': 'Não', 'score': 0},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScoreList = List<int>.filled(18, 0);

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
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final titleAA = routeArgs['title'];
    final _userEscala = routeArgs["userEscala"];
    final _answeredUntil = routeArgs['answeredUntil'];
    final _userEmail = routeArgs['email'];
    var index = _answeredUntil as int;

    if (_questionIndex < index) {
      _questionIndex = index;
    }

    print("Mdq_screen: " + _userEmail);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAA),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Mdq(
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                userEmail: _userEmail,
                resultScoreList: _totalScoreList,
                userEscala: _userEscala,
                questName: titleAA,
              ) //Quiz
            : MdqResult(
                resultScoreList: _totalScoreList,
                questName: titleAA,
                userEscala: _userEscala,
                userEmail: _userEmail,
                questionIndex: _questionIndex,
              ),
      ), //Padding
    ); //Scaffold
  }
}
