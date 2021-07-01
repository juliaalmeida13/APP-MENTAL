import 'package:flutter/material.dart';
//import 'fancy_button.dart'
import 'package:chat_app_tutorial/escalas/pcl5/pcl5.dart';
import 'package:chat_app_tutorial/escalas/pcl5/pcl5_result.dart';

class Pcl5Screen extends StatefulWidget {
  static const routeName = '/pcl5-screen';

  @override
  _Pcl5ScreenState createState() {
    return _Pcl5ScreenState();
  }
}

class _Pcl5ScreenState extends State<Pcl5Screen> {
  static const _questions = [
    {
      'questionText':
          'A seguir há uma lista de problemas que as pessoas às vezes apresentam em resposta a uma experiência muito estressante. Por favor, leia cuidadosamente cada problema e então selecione uma das opções para indicar o quanto você tem sido incomodado por este problema no último mês',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0, 'index': 0},
      ],
    },
    {
      'questionText':
          '1. Lembranças indesejáveis, pertubadoras e repetitivas da experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 1},
        {'text': 'Um pouco', 'score': 1, 'index': 1},
        {'text': 'Moderadamente', 'score': 2, 'index': 1},
        {'text': 'Muito', 'score': 3, 'index': 1},
        {'text': 'Extremamente', 'score': 4, 'index': 1},
      ],
    },
    {
      'questionText':
          '2. Sonhos pertubadores e repetitivos com a experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 2},
        {'text': 'Um pouco', 'score': 1, 'index': 2},
        {'text': 'Moderadamente', 'score': 2, 'index': 2},
        {'text': 'Muito', 'score': 3, 'index': 2},
        {'text': 'Extremamente', 'score': 4, 'index': 2},
      ],
    },
    {
      'questionText':
          '3. De repente, sentindo ou agindo como se a experiência estressante estivesse, de fato, acontecendo de novo (como se você estivesse revivendo-a, de verdade, lá no passado)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 3},
        {'text': 'Um pouco', 'score': 1, 'index': 3},
        {'text': 'Moderadamente', 'score': 2, 'index': 3},
        {'text': 'Muito', 'score': 3, 'index': 3},
        {'text': 'Extremamente', 'score': 4, 'index': 3},
      ],
    },
    {
      'questionText':
          '4. Sentir-se muito chateado quando algo lembra você da experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 4},
        {'text': 'Um pouco', 'score': 1, 'index': 4},
        {'text': 'Moderadamente', 'score': 2, 'index': 4},
        {'text': 'Muito', 'score': 3, 'index': 4},
        {'text': 'Extremamente', 'score': 4, 'index': 4},
      ],
    },
    {
      'questionText':
          '5. Ter reações físicas intensas quando algo lembra você da experiência estressante (por exemplo, coração apertado, dificuldade para respirar, suor excessivo)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 5},
        {'text': 'Um pouco', 'score': 1, 'index': 5},
        {'text': 'Moderadamente', 'score': 2, 'index': 5},
        {'text': 'Muito', 'score': 3, 'index': 5},
        {'text': 'Extremamente', 'score': 4, 'index': 5},
      ],
    },
    {
      'questionText':
          '6. Evitar lembranças, pensamentos, ou sentimentos relacionados à experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 6},
        {'text': 'Um pouco', 'score': 1, 'index': 6},
        {'text': 'Moderadamente', 'score': 2, 'index': 6},
        {'text': 'Muito', 'score': 3, 'index': 6},
        {'text': 'Extremamente', 'score': 4, 'index': 6},
      ],
    },
    {
      'questionText':
          '7. Evitar lembranças externas da experiência estressante (por exemplo, pessoas, lugares, conversas, atividades, objetos, ou situações)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 7},
        {'text': 'Um pouco', 'score': 1, 'index': 7},
        {'text': 'Moderadamente', 'score': 2, 'index': 7},
        {'text': 'Muito', 'score': 3, 'index': 7},
        {'text': 'Extremamente', 'score': 4, 'index': 7},
      ],
    },
    {
      'questionText':
          '8. Não conseguir se lembrar de partes importantes da experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 8},
        {'text': 'Um pouco', 'score': 1, 'index': 8},
        {'text': 'Moderadamente', 'score': 2, 'index': 8},
        {'text': 'Muito', 'score': 3, 'index': 8},
        {'text': 'Extremamente', 'score': 4, 'index': 8},
      ],
    },
    {
      'questionText':
          '9. Ter crenças negativas intensas sobre você, outras pessoas ou o mundo (por  exemplo, ter pensamentos tais como: “Eu sou ruim”, “existe algo seriamente errado  comigo”, “ninguém é confiável”, “o mundo todo é perigoso”)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 9},
        {'text': 'Um pouco', 'score': 1, 'index': 9},
        {'text': 'Moderadamente', 'score': 2, 'index': 9},
        {'text': 'Muito', 'score': 3, 'index': 9},
        {'text': 'Extremamente', 'score': 4, 'index': 9},
      ],
    },
    {
      'questionText':
          '10. Culpar a si mesmo ou aos outros pela experiência estressante ou pelo que  aconteceu depois dela?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 10},
        {'text': 'Um pouco', 'score': 1, 'index': 10},
        {'text': 'Moderadamente', 'score': 2, 'index': 10},
        {'text': 'Muito', 'score': 3, 'index': 10},
        {'text': 'Extremamente', 'score': 4, 'index': 10},
      ],
    },
    {
      'questionText':
          '11. Ter sentimentos negativos intensos como medo, pavor, raiva, culpa ou vergonha? ',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 11},
        {'text': 'Um pouco', 'score': 1, 'index': 11},
        {'text': 'Moderadamente', 'score': 2, 'index': 11},
        {'text': 'Muito', 'score': 3, 'index': 11},
        {'text': 'Extremamente', 'score': 4, 'index': 11},
      ],
    },
    {
      'questionText':
          '12. Perder o interesse em atividades que você costumava apreciar? ',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 12},
        {'text': 'Um pouco', 'score': 1, 'index': 12},
        {'text': 'Moderadamente', 'score': 2, 'index': 12},
        {'text': 'Muito', 'score': 3, 'index': 12},
        {'text': 'Extremamente', 'score': 4, 'index': 12},
      ],
    },
    {
      'questionText': '13. Sentir-se distante ou isolado das outras pessoas?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 13},
        {'text': 'Um pouco', 'score': 1, 'index': 13},
        {'text': 'Moderadamente', 'score': 2, 'index': 13},
        {'text': 'Muito', 'score': 3, 'index': 13},
        {'text': 'Extremamente', 'score': 4, 'index': 13},
      ],
    },
    {
      'questionText':
          '14. Dificuldades para vivenciar sentimentos positivos (por exemplo, ser incapaz de  sentir felicidade ou sentimentos amorosos por pessoas próximas a você)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 14},
        {'text': 'Um pouco', 'score': 1, 'index': 14},
        {'text': 'Moderadamente', 'score': 2, 'index': 14},
        {'text': 'Muito', 'score': 3, 'index': 14},
        {'text': 'Extremamente', 'score': 4, 'index': 14},
      ],
    },
    {
      'questionText':
          '15. Comportamento irritado, explosões de raiva ou agir agressivamente?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 15},
        {'text': 'Um pouco', 'score': 1, 'index': 15},
        {'text': 'Moderadamente', 'score': 2, 'index': 15},
        {'text': 'Muito', 'score': 3, 'index': 15},
        {'text': 'Extremamente', 'score': 4, 'index': 15},
      ],
    },
    {
      'questionText':
          '16. Correr muitos riscos ou fazer coisas que podem lhe causar algum mal?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 16},
        {'text': 'Um pouco', 'score': 1, 'index': 16},
        {'text': 'Moderadamente', 'score': 2, 'index': 16},
        {'text': 'Muito', 'score': 3, 'index': 16},
        {'text': 'Extremamente', 'score': 4, 'index': 16},
      ],
    },
    {
      'questionText': '17. Ficar “super” alerta, vigilante ou de sobreaviso?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 17},
        {'text': 'Um pouco', 'score': 1, 'index': 17},
        {'text': 'Moderadamente', 'score': 2, 'index': 17},
        {'text': 'Muito', 'score': 3, 'index': 17},
        {'text': 'Extremamente', 'score': 4, 'index': 17},
      ],
    },
    {
      'questionText': '18. Sentir-se apreensivo ou assustado facilmente?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 18},
        {'text': 'Um pouco', 'score': 1, 'index': 18},
        {'text': 'Moderadamente', 'score': 2, 'index': 18},
        {'text': 'Muito', 'score': 3, 'index': 18},
        {'text': 'Extremamente', 'score': 4, 'index': 18},
      ],
    },
    {
      'questionText': '19. Ter dificuldades para se concentrar?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 19},
        {'text': 'Um pouco', 'score': 1, 'index': 19},
        {'text': 'Moderadamente', 'score': 2, 'index': 19},
        {'text': 'Muito', 'score': 3, 'index': 19},
        {'text': 'Extremamente', 'score': 4, 'index': 19},
      ],
    },
    {
      'questionText': '20. Problemas para adormecer ou continuar dormindo?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0, 'index': 20},
        {'text': 'Um pouco', 'score': 1, 'index': 20},
        {'text': 'Moderadamente', 'score': 2, 'index': 20},
        {'text': 'Muito', 'score': 3, 'index': 20},
        {'text': 'Extremamente', 'score': 4, 'index': 20},
      ],
    },
  ];

  //(p. ex. analgésicos, estimulantes, sedativos ou tranquilizantes, ou drogas como maconha, cocaína ou crack, drogas sintéticas, alucinógenos, heroína, inalantes ou solventes ou metanfetamina?
  var _questionIndex = 0;
  var _totalScoreList = List<int>.filled(20, 0);

  void _answerQuestion(int score, int index) {
    _totalScoreList[index] += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print("qIndex : $_questionIndex");
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
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
        title: Text(titleAA),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Pcl5(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                userEmail: _userEmail,
                resultScoreList: _totalScoreList,
                userEscala: _userEscala,
                questName: titleAA,
              ) //Quiz
            : Pcl5Result(
                resultScoreList: _totalScoreList,
                questName: titleAA,
                userEscala: _userEscala,
                userEmail: _userEmail,
                questionIndex: _questionIndex,
              ),
      ), //Padding
    ); //Scaffold
    // debugShowCheckedModeBanner: false,;
  }
}
