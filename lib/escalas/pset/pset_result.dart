import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';

class PsetResult extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  PsetResult(
      {required this.userEmail,
      required this.questName,
      required this.userEscala});

  @override
  State<PsetResult> createState() => _PsetResultState();
}

class _PsetResultState extends State<PsetResult> {
  List<int> scoreList = [];

  @override
  void initState() {
    getScore();
    super.initState();
  }

  getScore() async {
    await QuestionnaireService()
        .getScore(widget.userEmail, "pset_week1")
        .then((values) {
      values.forEach((value) {
        scoreList.add(int.parse(value));
      });
    });
  }

  verifyScore() async {
    if (scoreList[0] == 1) {
      String pcl5UserEscala = "${widget.userEscala}-pcl5";
      List<String> week = widget.questName.split("-");
      String pcl5QuestName = "PCL-5" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pcl5",
        "questName": pcl5QuestName,
        "availableAt": DateTime.now(),
        "userEscala": pcl5UserEscala,
        "answeredUntil": 0,
      };
      //criar questionario para esse usuario
      //DatabaseMethods().createQuest(pcl5UserEscala, questMap, email);
    }
  }

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
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Êxito!'),
                  content: const Text(
                      'Sua resposta foi enviada!\n Novas atividades serão disponibilizadas em breve.'),
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
            },
          ),
        ),
      ],
    );
  }
}
