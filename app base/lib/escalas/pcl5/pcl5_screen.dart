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
        {'text': 'Entendi e quero prosseguir', 'score': 0},
      ],
    },
    {
      'questionText':
          '1. Lembranças indesejáveis, pertubadoras e repetitivas da experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '2. Sonhos pertubadores e repetitivos com a experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '3. De repente, sentindo ou agindo como se a experiência estressante estivesse, de fato, acontecendo de novo (como se você estivesse revivendo-a, de verdade, lá no passado)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '4. Sentir-se muito chateado quando algo lembra você da experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '5. Ter reações físicas intensas quando algo lembra você da experiência estressante (por exemplo, coração apertado, dificuldade para respirar, suor excessivo)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '6. Evitar lembranças, pensamentos, ou sentimentos relacionados à experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '7. Evitar lembranças externas da experiência estressante (por exemplo, pessoas, lugares, conversas, atividades, objetos, ou situações)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '8. Não conseguir se lembrar de partes importantes da experiência estressante?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '9. Ter crenças negativas intensas sobre você, outras pessoas ou o mundo (por  exemplo, ter pensamentos tais como: “Eu sou ruim”, “existe algo seriamente errado  comigo”, “ninguém é confiável”, “o mundo todo é perigoso”)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '10. Culpar a si mesmo ou aos outros pela experiência estressante ou pelo que  aconteceu depois dela?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '11. Ter sentimentos negativos intensos como medo, pavor, raiva, culpa ou vergonha? ',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '12. Perder o interesse em atividades que você costumava apreciar? ',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText': '13. Sentir-se distante ou isolado das outras pessoas?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '14. Dificuldades para vivenciar sentimentos positivos (por exemplo, ser incapaz de  sentir felicidade ou sentimentos amorosos por pessoas próximas a você)?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '15. Comportamento irritado, explosões de raiva ou agir agressivamente?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText':
          '16. Correr muitos riscos ou fazer coisas que podem lhe causar algum mal?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText': '17. Ficar “super” alerta, vigilante ou de sobreaviso?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText': '18. Sentir-se apreensivo ou assustado facilmente?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText': '19. Ter dificuldades para se concentrar?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
    {
      'questionText': '20. Problemas para adormecer ou continuar dormindo?',
      'answers': [
        {'text': 'De modo nenhum', 'score': 0},
        {'text': 'Um pouco', 'score': 1},
        {'text': 'Moderadamente', 'score': 2},
        {'text': 'Muito', 'score': 3},
        {'text': 'Extremamente', 'score': 4},
      ],
    },
  ];

  //(p. ex. analgésicos, estimulantes, sedativos ou tranquilizantes, ou drogas como maconha, cocaína ou crack, drogas sintéticas, alucinógenos, heroína, inalantes ou solventes ou metanfetamina?
  var _questionIndex = 0;
  var _totalScoreList = 0;

  /*void _resetQuiz(BuildContext ctx) {
    _questionIndex = 0;
    _totalScore = 0;
    Navigator.of(ctx).pop();
    /*setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    }); */
*/
  void _answerQuestion(int score) {
    _totalScoreList += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print('ahn');
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final titleAA = routeArgs['title'];
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
              ) //Quiz
            : Pcl5Result(resultScoreList: _totalScoreList),
      ), //Padding
    ); //Scaffold
    // debugShowCheckedModeBanner: false,;
  }
}
