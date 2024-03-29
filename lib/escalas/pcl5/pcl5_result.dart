import 'package:app_mental/Services/database.dart';
import 'package:flutter/material.dart';
// import './categories_screen.dart';

class Pcl5Result extends StatelessWidget {
  final List<int> resultScoreList;
  final List<Object> resultOptionList;
  final String questName;
  final String userEscala;
  final String userEmail;
  final int questionIndex;
  final DateTime now = DateTime.now();
  //final Function resetHandler;
  final String resultPhrase =
      'PCL-5 concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  sendPcl5Result(String email) {
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
      "q11": resultScoreList[11],
      "q12": resultScoreList[12],
      "q13": resultScoreList[13],
      "q14": resultScoreList[14],
      "q15": resultScoreList[15],
      "q16": resultScoreList[16],
      "q17": resultScoreList[17],
      "q18": resultScoreList[18],
      "q19": resultScoreList[19],
      "q20": resultScoreList[20],
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
      "option15": resultOptionList[15],
      "option16": resultOptionList[16],
      "option17": resultOptionList[17],
      "option18": resultOptionList[18],
      "option19": resultOptionList[19],
      "option20": resultOptionList[20],
      "answeredAt": now,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, email, userEscala);
    databaseMethods.updateQuestIndex(userEscala, email, questionIndex);
    databaseMethods.disableQuest(userEscala, email);
  }

  Pcl5Result({
    required this.resultScoreList,
    required this.resultOptionList,
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
              sendPcl5Result(userEmail);
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Êxito!'),
                  content: const Text(
                      'Suas respostas foram enviadas!\n Novas atividades serão disponibilizadas em breve.'),
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
