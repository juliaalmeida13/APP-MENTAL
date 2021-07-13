import 'package:chat_app_tutorial/main.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_tutorial/Services/database.dart';

class PsetResult extends StatelessWidget {
  final int resultScore;
  final String userEmail;
  final String questName;
  final String userEscala;
  final int questionIndex;
  final DateTime now = DateTime.now();
  final DatabaseMethods databaseMethods = new DatabaseMethods();

  sendPsetResult(String email) async {
    Map<String, dynamic> psetMap = {
      "hasBeenThrough": resultScore,
      "answeredAt": now,
      "questName": questName,
    };
    databaseMethods.addQuestAnswer(psetMap, userEmail, userEscala);

    if (resultScore == 1) {
      String pcl5UserEscala = "$userEscala-pcl5";
      List<String> week = questName.split("-");
      String pcl5QuestName = "PCL-5" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pcl5",
        "questName": pcl5QuestName,
        "availableAt": now,
        "userEscala": pcl5UserEscala,
        "answeredUntil": 0,
      };
      DatabaseMethods().createQuest(pcl5UserEscala, questMap, email);
    }

    databaseMethods.disableQuest(userEscala, email);
  }

  PsetResult({
    this.resultScore,
    this.userEmail,
    this.questName,
    this.userEscala,
    this.questionIndex,
  });

  /* void _returnMenu(BuildContext ctx) {
    Navigator.of(ctx).push(
      CategoriesScreen.routeName,
    );
  }*/

  final String resultPhrase =
      'Respondido! \n\nSua resposta será enviada e analisada anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

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
              sendPsetResult(userEmail);
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Êxito!'),
                  content: const Text(
                      'Sua resposta foi enviada!\n Novas atividades serão disponibilizadas em breve.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        //enviarDominios(userEmail);
                        Navigator.pop(context, 'Ok');
                        await Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => MyApp()));
                        //Navigator.pop(context, 'OK');
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
