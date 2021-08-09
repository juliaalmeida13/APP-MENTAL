import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Services/database.dart';
import 'package:flutter/material.dart';

class PromisAnsiResult extends StatelessWidget {
  final List<int> resultScoreList;
  final int questionIndex;
  final String userEmail;
  final String questName;
  final String userEscala;
  final DateTime instantTime = DateTime.now();

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  sendPromisAnsiScore(String email) {
    Map<String, dynamic> answerMap = {
      "q1": resultScoreList[1],
      "q2": resultScoreList[2],
      "q3": resultScoreList[3],
      "q4": resultScoreList[4],
      "q5": resultScoreList[5],
      "q6": resultScoreList[6],
      "q7": resultScoreList[7],
      "answeredAt": instantTime,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, email, userEscala);
    databaseMethods.updateQuestIndex(userEscala, email, questionIndex);
    databaseMethods.disableQuest(userEscala, email);
  }

  isCritical() {
    int sum =
        resultScoreList.fold(0, (previous, current) => previous + current);
    if (sum > 19) {
      return true;
    } else {
      return false;
    }
  }

  PromisAnsiResult({
    required this.resultScoreList,
    required this.questionIndex,
    required this.userEmail,
    required this.questName,
    required this.userEscala,
  });

  final String resultPhrase =
      'PROMIS Nível 2 (Ansiedade) concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

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
              sendPromisAnsiScore(userEmail);
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
                          await Navigator.of(context).pushNamed(
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
                          Navigator.pop(context, 'Ok');
                          await Navigator.of(context).push(
                              new MaterialPageRoute(
                                  builder: (context) => MyApp()));
                          //Navigator.pop(context, 'OK');
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
