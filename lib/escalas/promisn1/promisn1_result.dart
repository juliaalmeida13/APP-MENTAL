import 'dart:ui';

import 'package:app_mental/Services/questionnaireService.dart';
import 'package:app_mental/main.dart';
import 'package:flutter/material.dart';

class Promisn1Result extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  Promisn1Result(
      {required this.questName,
      required this.userEscala,
      required this.userEmail});

  @override
  State<Promisn1Result> createState() => _Promisn1ResultState();
}

class _Promisn1ResultState extends State<Promisn1Result> {
  final String resultPhrase =
      'PROMIS Nível 1 concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';
  List<int> scoreList = [];

  @override
  void initState() {
    getScore();
    super.initState();
  }

  getScore() async {
    await QuestionnaireService()
        .getScore(widget.userEmail, "promisN1_week1")
        .then((values) {
      values.forEach((value) {
        scoreList.add(int.parse(value));
      });
    });
  }

  verifyScore() async {
    if (scoreList[1] + scoreList[2] > 2) {
      String promisn2UserEscala = "${widget.userEscala}-promisN2";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName = "Escala PROMIS Nível 2" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pn2",
        "questName": promisn2QuestName,
        "availableAt": DateTime.now(),
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      //cria questionário
      //databaseMethods.createQuest(promisn2UserEscala, questMap, FirebaseAuth.instance.currentUser!.uid);*/
    }

    /*if (scoreList[4]+scoreList[5] > 2) {
      String mdqUserEscala = "$userEscala-Mdq";
      List<String> week = questName.split("-");
      String mdqQuestName =
          "Questionário de Transtorno de Humor" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "mdq",
        "questName": mdqQuestName,
        "availableAt": now,
        "userEscala": mdqUserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(mdqUserEscala, questMap, email);
    }

    if (scoreList[6]+scoreList[7]+scoreList[8] > 2) {
      String promisAnsiUserEscala = "$userEscala-PromisAnsi";
      List<String> week = questName.split("-");
      String promisAnsiQuestName =
          "Escala PROMIS Nível 2 (Ansiedade)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pn2A",
        "questName": promisAnsiQuestName,
        "availableAt": now,
        "userEscala": promisAnsiUserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisAnsiUserEscala, questMap, email);
    }

    if (scoreList[9]+scoreList[10] > 2) {
      String phq15UserEscala = "$userEscala-Phq15";
      List<String> week = questName.split("-");
      String phq15QuestName =
          "Questionário de Saúde do Paciente" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "phq15",
        "questName": phq15QuestName,
        "availableAt": now,
        "userEscala": phq15UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(phq15UserEscala, questMap, email);
    }

    if (scoreList[14] > 2) {
      String psqiUserEscala = "$userEscala-Psqi";
      List<String> week = questName.split("-");
      String psqiQuestName =
          "Índice de Qualidae de Sono de Pittsburrgh" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "psqi",
        "questName": psqiQuestName,
        "availableAt": now,
        "userEscala": psqiUserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(psqiUserEscala, questMap, email);
    }

    if (scoreList[21]+scoreList[22]+scoreList[23] > 1) {
      String assistUserEscala = "$userEscala-Assist";
      List<String> week = questName.split("-");
      String assistQuestName = "ASSIST OMS" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assist",
        "questName": assistQuestName,
        "availableAt": now,
        "userEscala": assistUserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(assistUserEscala, questMap, email);
    }*/
  }

  isCritical() {
    //dom 2, 9, 10, 11, 12, leve ou maior (>2)
    //dom 6, 7 muito leve ou maior (>1)
    return (scoreList[2] > 2 ||
        scoreList[6] > 1 ||
        scoreList[7] > 1 ||
        scoreList[9] > 2 ||
        scoreList[10] > 2 ||
        scoreList[11] > 2 ||
        scoreList[12] > 2);
  }

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
                        child: const Text('Ok',
                            style: TextStyle(
                                color: Color.fromRGBO(104, 202, 138, 1))),
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

  void showAlert(BuildContext context) {
    Widget voltarButton = TextButton(
      child: Text("Voltar",
          style: TextStyle(color: Color.fromRGBO(0, 175, 185, 1))),
      onPressed: () async {
        verifyScore();
        Navigator.pop(context, 'Voltar');
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => MyApp()));
      },
    );
    // configura o  Alert
    Widget alert = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text(
            "Parabéns por responder ao questionário!!",
            textAlign: TextAlign.center,
          ),
          content: Image(image: AssetImage('assets/images/unicorn.png')),
          actions: [
            voltarButton,
          ],
        ));
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
