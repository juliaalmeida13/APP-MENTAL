import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';

class PsqiResult extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  PsqiResult({
    required this.userEmail,
    required this.questName,
    required this.userEscala,
  });

  @override
  State<PsqiResult> createState() => _PsqiResultState();
}

class _PsqiResultState extends State<PsqiResult> {
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
        .getScore(widget.userEmail, "psqi_week1")
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
    if (score > 4) {
      /*Map<String, dynamic> readingsMap1 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono1",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono1", readingsMap1, email);

      Map<String, dynamic> readingsMap2 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono2",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono2", readingsMap2, email);

      Map<String, dynamic> readingsMap3 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono3",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono3", readingsMap3, email);

      Map<String, dynamic> readingsMap4 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono4",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono4", readingsMap4, email);*/
      //aparece uma flag no card das leituras e depois na area de higiene do sono pro usuário ir clicando e vai sumir assim que o usuário entrar na leitura

      setState(() {
        hasRecommendation = true;
      });
    }
  }

  isCritical() {
    if (score > 10) {
      return true;
    } else {
      return false;
    }
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
                          Navigator.pop(context, 'Ok');
                          await Navigator.pushReplacementNamed(
                            context,
                            ContactsScreen.routeName,
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
