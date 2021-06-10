import 'package:flutter/material.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/database.dart';
// import './categories_screen.dart';

class Promisn1Result extends StatelessWidget {
  final List<int> resultScoreList;
  final int resultScore;
  String userEmail;
  DateTime instantTime;
  //final Function resetHandler;

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  enviarDominios(String email) {
    instantTime = DateTime.now();
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
      "answeredAt": instantTime,
      "questName": "PROMIS Nível 1",
    };
    databaseMethods.addQuestAnswer(promisn1Map, userEmail, "promisN1");
    if (resultScoreList[1] > 2) {
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pn2",
        "questName": "PROMIS Nível 2",
        "availableAt": instantTime,
        "index": 0,
      };
      DatabaseMethods().createQuest("promisN2", questMap, email);
      DatabaseMethods().disableQuest("promisN1", email);
    }
  }

  void getUserInfo() async {
    userEmail = await HelperFunctions.getUserEmailInSharedPreference();
    userEmail = userEmail.trim();
    enviarDominios(userEmail);
  }

  Promisn1Result({this.resultScoreList, this.resultScore});

  /* void _returnMenu(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesScreen.routeName,
    );
  }*/

  final String resultPhrase =
      'Questionário concluído! \n\nFique atento às próximas atividades.';

  @override
  Widget build(BuildContext context) {
    getUserInfo();
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
      ],
    );
  }
}
