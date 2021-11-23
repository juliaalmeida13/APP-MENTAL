import 'package:app_mental/Services/database.dart';
import 'package:flutter/material.dart';

class AssistResult extends StatelessWidget {
  final List<int> resultScoreList;
  final List<Object> resultOptionList;
  final int questionIndex;
  final String userEmail;
  final String questName;
  final String userEscala;
  final DateTime instantTime = DateTime.now();
  final DatabaseMethods databaseMethods = new DatabaseMethods();

  sendAssistScore(String email) async {
    Map<String, dynamic> answerMap = {
      "q1": resultScoreList[1],
      "q2": resultScoreList[2],
      "q3": resultScoreList[3],
      "q4": resultScoreList[4],
      "q5": resultScoreList[5],
      "q6": resultScoreList[6],
      "q7": resultScoreList[7],
      "q8": resultScoreList[8],
      "q9": resultScoreList[9],
      "q10": resultScoreList[10],
      "option1": resultOptionList[1],
      "option2": resultOptionList[2],
      "option3": resultOptionList[3],
      "option4": resultOptionList[4],
      "option5": resultOptionList[5],
      "option6": resultOptionList[6],
      "option7": resultOptionList[7],
      "option8": resultOptionList[8],
      "option9": resultOptionList[9],
      "option10": resultOptionList[10],
      "answeredAt": instantTime,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, email, userEscala);
    databaseMethods.updateQuestIndex(userEscala, email, questionIndex);
    databaseMethods.disableQuest(userEscala, email);

    var answerQ1 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q1");
    if (answerQ1.docs[0].get("q1") == 1) {
      String promisn2UserEscala = "$userEscala-assistN2-tabaco";
      List<String> week = questName.split("-");
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

    var answerQ2 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q2");
    if (answerQ2.docs[0].get("q2") == 1) {
      String promisn2UserEscala = "$userEscala-assistN2-alcool";
      List<String> week = questName.split("-");
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

    var answerQ3 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q3");
    if (answerQ3.docs[0].get("q3") == 1) {
      String promisn2UserEscala = "$userEscala-assistN2-maconha";
      List<String> week = questName.split("-");
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

    var answerQ4 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q4");
    if (answerQ4.docs[0].get("q4") == 1) {
      String promisn2UserEscala = "$userEscala-assistN2-crack";
      List<String> week = questName.split("-");
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

    var answerQ5 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q5");
    if (answerQ5.docs[0].get("q5") == 1) {
      String promisn2UserEscala = "$userEscala-assistN2-anf";
      List<String> week = questName.split("-");
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

    var answerQ6 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q6");
    if (answerQ6.docs[0].get("q6") == 1) {
      String promisn2UserEscala = "$userEscala-assistN20-inalantes";
      List<String> week = questName.split("-");
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

    var answerQ7 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q7");
    if (answerQ7.docs[0].get("q7") == 1) {
      String promisn2UserEscala = "$userEscala-assistN2-hipno";
      List<String> week = questName.split("-");
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

    var answerQ8 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q8");
    if (answerQ8.docs[0].get("q8") == 1) {
      String promisn2UserEscala = "$userEscala-assistN2-aluci";
      List<String> week = questName.split("-");
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

    var answerQ9 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q9");
    if (answerQ9.docs[0].get("q9") == 1) {
      String promisn2UserEscala = "$userEscala-assistN2-opio";
      List<String> week = questName.split("-");
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
    var answerQ10 =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "q10");
    if (answerQ10.docs[0].get("q10") == 1) {
      String promisn2UserEscala = "$userEscala-assistN2-outroas";
      List<String> week = questName.split("-");
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
    }
  }

  AssistResult({
    required this.resultScoreList,
    required this.resultOptionList,
    required this.questionIndex,
    required this.userEmail,
    required this.questName,
    required this.userEscala,
  });

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
              sendAssistScore(userEmail);
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Êxito!'),
                  content: const Text(
                      'Suas respostas foram enviadas!\nNovas atividades serão disponibilizadas em breve.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context, "Ok");
                        Navigator.pop(context);
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
