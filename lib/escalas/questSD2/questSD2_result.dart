import 'package:app_mental/Services/database.dart';
import 'package:flutter/material.dart';

class QuestSD2Result extends StatelessWidget {
  final List<Object> resultScoreList;
  final List<Object> resultOptionList;
  final int questionIndex;
  final String userEmail;
  final String questName;
  final String userEscala;
  final DateTime instantTime = DateTime.now();
  //final Function resetHandler;

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  sendQuestSD2Score(String email) {
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
      "q10": resultScoreList[9],
      "q11": resultScoreList[9],
      "q12": resultScoreList[9],
      "q13": resultScoreList[9],
      "q14": resultScoreList[9],
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
      "option11": resultOptionList[11],
      "option12": resultOptionList[12],
      "option13": resultOptionList[13],
      "option14": resultOptionList[14],
      "answeredAt": instantTime,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    print("que te pasas $userEscala $questName $questionIndex");
    databaseMethods.addQuestAnswer(answerMap, email, userEscala);
    databaseMethods.updateQuestIndex(userEscala, email, questionIndex);
    databaseMethods.disableQuest(userEscala, email);
  }

  QuestSD2Result({
    required this.resultScoreList,
    required this.resultOptionList,
    required this.questionIndex,
    required this.userEmail,
    required this.questName,
    required this.userEscala,
  });

  final String resultPhrase =
      'Segunda e última parte do Questionário Sociodemográfico concluída! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

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
              sendQuestSD2Score(userEmail);
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
