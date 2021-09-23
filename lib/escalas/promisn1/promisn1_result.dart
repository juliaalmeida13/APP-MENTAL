import 'dart:ui';

import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/main.dart';
import 'package:flutter/material.dart';
// import './categories_screen.dart';

class Promisn1Result extends StatelessWidget {
  final List<int> resultScoreList;
  final String questName;
  final String userEscala;
  final String userEmail;
  final int questionIndex;
  final DateTime now = DateTime.now();
  //final Function resetHandler;
  final String resultPhrase =
      'PROMIS Nível 1 concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  enviarDominios(String email) async {
    Map<String, dynamic> promisn1Map = {
      "dom1": resultScoreList[1],
      "dom2": resultScoreList[2],
      "dom3": resultScoreList[3],
      "dom4": resultScoreList[4],
      "dom5": resultScoreList[5],
      "dom6": resultScoreList[6],
      "dom7": resultScoreList[7],
      "dom8": resultScoreList[8],
      "dom9": resultScoreList[9],
      "dom10": resultScoreList[10],
      "dom11": resultScoreList[11],
      "dom12": resultScoreList[12],
      "dom13": resultScoreList[13],
      "answeredAt": now,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    print("EnviarDominios userEmail/userEscala PromisResult");
    print(email);
    print(userEscala);
    await databaseMethods.addQuestAnswer(promisn1Map, email, userEscala);
    var doms = await databaseMethods.getDomTotal(
      userEmail,
      userEscala,
      "dom1",
    );
    if (doms[1] > 2) {
      String promisn2UserEscala = "$userEscala-promisN2";
      List<String> week = questName.split("-");
      String promisn2QuestName = "Escala PROMIS Nível 2" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pn2",
        "questName": promisn2QuestName,
        "availableAt": now,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    if (doms[3] > 2) {
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

    if (doms[4] > 2) {
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

    if (doms[5] > 2) {
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

    if (doms[8] > 2) {
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

    if (doms[13] > 1) {
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
    }

    databaseMethods.updateQuestIndex(userEscala, email, questionIndex);
    databaseMethods.disableQuest(userEscala, email);
  }

  isCritical() {
    //dom 2, 9, 10, 11, 12, leve ou maior (>2)
    //dom 6, 7 muito leve ou maior (>1)
    if (resultScoreList[2] > 2 ||
        resultScoreList[6] > 1 ||
        resultScoreList[7] > 1 ||
        resultScoreList[9] > 2 ||
        resultScoreList[10] > 2 ||
        resultScoreList[11] > 2 ||
        resultScoreList[12] > 2) {
      return true;
    } else {
      return false;
    }
  }

  Promisn1Result({
    required this.resultScoreList,
    required this.questName,
    required this.userEscala,
    required this.userEmail,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          resultPhrase,
          style: TextStyle(
            fontSize: 26,
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
              enviarDominios(userEmail);
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
                          //enviarDominios(userEmail);
                          Navigator.pop(context);
                          Navigator.pop(context);
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
    //Future.delayed(Duration.zero, () => showAlert(context));

    /*return Container(
        /*FlatButton(
          child: Text('Retornar ao menu'),
          textColor: Colors.blue,
          onPressed: () => {
            Navigator.of(context).pushNamed(
              CategoriesScreen.routeName,
              arguments: {},
            )
          },
        ),*/

        );*/
  }

  void showAlert(BuildContext context) {
    Widget voltarButton = TextButton(
      child: Text("Voltar",
          style: TextStyle(color: Color.fromRGBO(0, 175, 185, 1))),
      onPressed: () async {
        /*var count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });*/
        enviarDominios(userEmail);
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
