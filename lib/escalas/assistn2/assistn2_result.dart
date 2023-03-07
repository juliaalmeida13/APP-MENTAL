import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';

class Assistn2Result extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  Assistn2Result(
      {required this.userEmail,
      required this.questName,
      required this.userEscala});

  @override
  State<Assistn2Result> createState() => _Assistn2ResultState();
}

class _Assistn2ResultState extends State<Assistn2Result> {
  bool hasRecommendation = false;
  int score = 0;

  @override
  void initState() {
    getScore();
    super.initState();
  }

  getScore() async {
    int sum = 0;
    await QuestionnaireService()
        .getScore(widget.userEmail, "assistn2_week1")
        .then((values) {
      for (var i = 5; i < values.length; i++) {
        sum = sum + int.parse(values[i]);
      }
    });
    if (sum != 0) {
      setState(() {
        score = sum;
      });
    }
  }

  verifyScore() {
    if (score > 3) {
      /*Map<String, dynamic> readingsMap1 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce1",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce1", readingsMap1, email);

      Map<String, dynamic> readingsMap2 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce2",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce2", readingsMap2, email);

      Map<String, dynamic> readingsMap3 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce3",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce3", readingsMap3, email);

      Map<String, dynamic> readingsMap4 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce4",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce4", readingsMap4, email);*/
      setState(() {
        hasRecommendation = true;
      });
    }
  }

  isCritical() {
    return score > 11;
  }

  final String resultPhrase =
      'Questionário concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          resultPhrase,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * .03,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(104, 202, 138, 1)),
            child: const Text('Sim, estou de acordo',
                style: TextStyle(color: Colors.black)),
            onPressed: () {
              verifyScore();
              if (isCritical()) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Entre em contato com alguém!'),
                    content: const Text(
                        'Percebemos que você pode estar em um estado bastante delicado e gostaríamos de sugerir que entre em contato conosco ou com alguém próximo!'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/logged-home'));
                          Navigator.of(context).pushNamed("/contacts-screen");
                        },
                        child: const Text('Ok',
                            style: TextStyle(
                                color: Color.fromRGBO(104, 202, 138, 1))),
                      ),
                    ],
                  ),
                );
              } else if (hasRecommendation) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Recomendações para você!'),
                    content: const Text(
                        'Seguindo uma análise rápida das suas respostas, algumas leituras ou vídeos foram recomendadas para você, e estarão disponíveis em sua tela inicial!'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context, 'Ok');
                          await Navigator.pushReplacementNamed(
                            context,
                            "/logged-home",
                            arguments: {},
                          );
                        },
                        child: const Text('Ok',
                            style: TextStyle(
                                color: Color.fromRGBO(104, 202, 138, 1))),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Êxito!'),
                    content: const Text(
                        'Suas respostas foram enviadas!\nNovas atividades serão disponibilizadas em breve.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/logged-home'));
                          Navigator.of(context).pushNamed("/quests-screen");
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
