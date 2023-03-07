import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';

class AssistResult extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  AssistResult(
      {required this.userEmail,
      required this.questName,
      required this.userEscala});

  @override
  State<AssistResult> createState() => _AssistResultState();
}

class _AssistResultState extends State<AssistResult> {
  List<int> scoreList = [];

  @override
  void initState() {
    getScore();
    super.initState();
  }

  getScore() async {
    await QuestionnaireService()
        .getScore(widget.userEmail, "assist_week1")
        .then((values) {
      values.forEach((value) {
        scoreList.add(int.parse(value));
      });
    });
  }

  verifyScore() async {
    /*var answerQ1 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q1");
    if (answerQ1.docs[0].get("q1") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN2-tabaco";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName =
          "ASSIST - (derivados do tabaco)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    var answerQ2 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q2");
    if (answerQ2.docs[0].get("q2") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN2-alcool";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName =
          "ASSIST - (bebidas alcoólicas)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    var answerQ3 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q3");
    if (answerQ3.docs[0].get("q3") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN2-maconha";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName = "ASSIST - (maconha)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    var answerQ4 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q4");
    if (answerQ4.docs[0].get("q4") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN2-crack";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName = "ASSIST - (cocaína, crack)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    var answerQ5 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q5");
    if (answerQ5.docs[0].get("q5") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN2-anf";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName =
          "ASSIST - (anfetaminas ou êxtase)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    var answerQ6 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q6");
    if (answerQ6.docs[0].get("q6") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN20-inalantes";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName = "ASSIST - (inalantes)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    var answerQ7 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q7");
    if (answerQ7.docs[0].get("q7") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN2-hipno";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName =
          "ASSIST - (hipnóticos ou sedativos)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    var answerQ8 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q8");
    if (answerQ8.docs[0].get("q8") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN2-aluci";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName = "ASSIST - (alucinógenos)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    var answerQ9 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q9");
    if (answerQ9.docs[0].get("q9") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN2-opio";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName = "ASSIST - (opioides)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }

    //to do
    //change answer type to String and use it in
    var answerQ10 = await databaseMethods.getDomFromAnswers(
        widget.userEmail, widget.userEscala, "q10");
    if (answerQ10.docs[0].get("q10") == 1) {
      String promisn2UserEscala = "${widget.userEscala}-assistN2-outroas";
      List<String> week = widget.questName.split("-");
      String promisn2QuestName =
          "ASSIST - (outras substâncias)" + " -" + week[1];
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "assistn2",
        "questName": promisn2QuestName,
        "availableAt": instantTime,
        "userEscala": promisn2UserEscala,
        "answeredUntil": 0,
      };
      databaseMethods.createQuest(promisn2UserEscala, questMap, email);
    }*/
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
            },
          ),
        ),
      ],
    );
  }
}
