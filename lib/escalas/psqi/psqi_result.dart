import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Services/database.dart';
import 'package:flutter/material.dart';

class PsqiResult extends StatelessWidget {
  final List<dynamic> resultScoreList;
  final List<Object> resultOptionList;
  final int questionIndex;
  final String userEmail;
  final String questName;
  final String userEscala;
  final DateTime instantTime = DateTime.now();

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  sendPsqiScore(String email) {
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
      "q21": resultScoreList[21],
      "q22": resultScoreList[22],
      "q23": resultScoreList[23],
      "q24": resultScoreList[24],
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
      "option21": resultOptionList[21],
      "option22": resultOptionList[22],
      "option23": resultOptionList[23],
      "option24": resultOptionList[24],
      "answeredAt": instantTime,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, email, userEscala);
    databaseMethods.updateQuestIndex(userEscala, email, questionIndex);
    databaseMethods.disableQuest(userEscala, email);

    List<int>? listOfInts = resultScoreList
        .where((x) => x.runtimeType == int)
        .map((x) => x as int)
        .toList();
    int sum = listOfInts.fold(0, (previous, current) => previous + current);
    if (sum > 4) {
      Map<String, dynamic> readingsMap1 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono1",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono1", readingsMap1, email);

      Map<String, dynamic> readingsMap2 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono2",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono2", readingsMap2, email);

      Map<String, dynamic> readingsMap3 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono3",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono3", readingsMap3, email);

      Map<String, dynamic> readingsMap4 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono4",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono4", readingsMap4, email);
    }
  }

  isCritical() {
    List<int>? listOfInts = resultScoreList
        .where((x) => x.runtimeType == int)
        .map((x) => x as int)
        .toList();
    int sum = listOfInts.fold(0, (previous, current) => previous + current);
    if (sum > 10) {
      return true;
    } else {
      return false;
    }
  }

  hasRecommendation() {
    List<int>? listOfInts = resultScoreList
        .where((x) => x.runtimeType == int)
        .map((x) => x as int)
        .toList();
    int sum = listOfInts.fold(0, (previous, current) => previous + current);
    if (sum > 4) {
      return true;
    } else {
      return false;
    }
  }

  PsqiResult({
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
              sendPsqiScore(userEmail);
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
