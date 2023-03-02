import 'package:app_mental/Services/questsService.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/escalas/questSD1/questSD1.dart';
import 'package:app_mental/escalas/questSD1/questSD1_result.dart';

import '../../constants.dart';
import '../../helper/helperfuncions.dart';

class QuestSD1Screen extends StatefulWidget {
  static const routeName = '/questSD1-screen';

  @override
  _QuestSD1ScreenState createState() {
    return _QuestSD1ScreenState();
  }
}

class _QuestSD1ScreenState extends State<QuestSD1Screen> {
  List<dynamic> _questions = [];
  late String userEmail;

  @override
  void initState() {
    getQuestions();
    getUserEmail();
    super.initState();
  }

  getQuestions() async {
    await QuestsService().getQuestions("questSD1_week1").then((values) {
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
        {'text': 'Feminino', 'score': 'F'},
        {'text': 'Masculino', 'score': 'M'},
        {'text': 'Outro', 'score': 'O'},
      ],
    },
    {
      'answers': [
        {'text': 'Entre 18 e 25', 'score': '18-25'},
        {'text': 'Entre 26 e 30', 'score': '26-20'},
        {'text': 'Entre 31 e 35', 'score': '31-35'},
        {'text': 'Entre 36 e 40', 'score': '36-40'},
        {'text': 'Entre 41 e 45', 'score': '41-45'},
        {'text': 'Entre 46 e 50', 'score': '46-50'},
        {'text': '51 ou mais', 'score': '51+'},
      ],
    },
    //TO DO marcar mais de uma opção
    {
      'answers': [
        {'text': 'Unidade Básica de Saúde (UBS)', 'score': 'UBS'},
        {'text': 'Unidade de Saúde da Família (USF)', 'score': 'USF'},
        {'text': 'Núcleo de apoio à saúde da família (NASF)', 'score': 'NASF'},
        {'text': 'Consultório na Rua', 'score': 'Consultório na Rua'},
      ],
    },
    {
      'answers': [
        {'text': '20 horas/semana', 'score': '20h/semana'},
        {'text': 'Entre 21 a 40 horas/ semanas', 'score': '20-40h/semana'},
        {'text': 'Mais de 40 horas/ semana', 'score': '40+h/semana'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'trabalha noite/madrugada'},
        {'text': 'Não', 'score': 'não trabalha noite/madrugada'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'mora sozinho'},
        {'text': 'Não', 'score': 'não mora sozinho'},
      ],
    },
    {
      'answers': [
        {'text': 'Sim', 'score': 'tem filhos -18'},
        {'text': 'Não', 'score': 'Não tem filhos -18'},
      ],
    },
    {
      'answers': [
        {'text': 'Solteiro(a)', 'score': 'Solteiro(a)'},
        {'text': 'Casado(a)', 'score': 'Casado(a)'},
        {'text': 'União Estável', 'score': 'União Estável'},
        {'text': 'Viúvo(a)', 'score': 'Viúvo(a)'},
      ],
    },

    //Overflow de pixel certo
    {
      'answers': [
        {
          'text': 'Agente comunitário de saúde',
          'score': 'Agente comunitário de saúde'
        },
        {'text': 'Auxiliar de enfermagem', 'score': 'Auxiliar de enfermagem'},
        {'text': 'Técnico de enfermagem', 'score': 'Técnico de enfermagem'},
        {'text': 'Enfermeiro', 'score': 'Enfermeiro'},
        {'text': 'Dentista', 'score': 'Dentista'},
        {'text': 'Médico', 'score': 'Médico'},
        {'text': 'Psicólogo', 'score': 'Psicólogo'},
        {'text': 'Terapeuta ocupacional', 'score': 'Terapeuta ocupacional'},
        {'text': 'Assistente social', 'score': 'Assistente social'},
        {'text': 'Fisioterapeuta', 'score': 'Fisioterapeuta'},
        {'text': 'Fonoaudiólogo', 'score': 'Fonoaudiólogo'},
        {'text': 'Nutricionista', 'score': 'Nutricionista'},
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion(Object score, Object answer) {
    QuestsService().addQuestionnaireAnswer(
        userEmail, answer, score, "questSD1_week1", _questionIndex);
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
            ? QuestSD1(
                sizeQuestionnaire: _questions.length - 1,
                answerQuestion: _answerQuestion,
                resetQuestion: _resetQuestion,
                questionIndex: _questionIndex,
                question: _questions[_questionIndex],
                answers: _answers,
              )
            : QuestSD1Result(),
      ),
    );
  }
}
