import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Services/database.dart';
import 'package:flutter/material.dart';

class Assistn2Result extends StatelessWidget {
  final List<int> resultScoreList;
  final List<Object> resultOptionList;
  final int questionIndex;
  final String userEmail;
  final String questName;
  final String userEscala;
  final DateTime instantTime = DateTime.now();
  final DatabaseMethods databaseMethods = new DatabaseMethods();

  sendAssistn2Score(String email) {
    Map<String, dynamic> answerMap = {
      "q1": resultScoreList[1],
      "q2": resultScoreList[2],
      "q3": resultScoreList[3],
      "q4": resultScoreList[4],
      "q5": resultScoreList[5],
      "q6": resultScoreList[6],
      "option1": resultOptionList[1],
      "option2": resultOptionList[2],
      "option3": resultOptionList[3],
      "option4": resultOptionList[4],
      "option5": resultOptionList[5],
      "option6": resultOptionList[6],
      "answeredAt": instantTime,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, email, userEscala);
    databaseMethods.updateQuestIndex(userEscala, email, questionIndex);
    databaseMethods.disableQuest(userEscala, email);

    int sum =
        resultScoreList.fold(0, (previous, current) => previous + current);
    if (sum > 3) {
      Map<String, dynamic> readingsMap1 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce1",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce1", readingsMap1, email);

      Map<String, dynamic> readingsMap2 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce2",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce2", readingsMap2, email);

      Map<String, dynamic> readingsMap3 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce3",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce3", readingsMap3, email);

      Map<String, dynamic> readingsMap4 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce4",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce4", readingsMap4, email);
    }
  }

  isCritical() {
    int sum =
        resultScoreList.fold(0, (previous, current) => previous + current);
    if (sum > 11) {
      return true;
    } else {
      return false;
    }
  }

  hasRecommendation() {
    int sum =
        resultScoreList.fold(0, (previous, current) => previous + current);
    if (sum > 3) {
      return true;
    } else {
      return false;
    }
  }

  Assistn2Result({
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
              sendAssistn2Score(userEmail);
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
              } else if (hasRecommendation()) {
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
                          //enviarDominios(userEmail);
                          Navigator.pop(context, "Ok");
                          Navigator.pop(context);
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
