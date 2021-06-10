import 'package:flutter/material.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/database.dart';
// import './categories_screen.dart';

class PsetResult extends StatelessWidget {
  final List<int> resultScoreList;
  final int resultScore;
  String userEmail;
  DateTime instantTime;
  //final Function resetHandler;

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  enviarDominios(String email) {
    instantTime = DateTime.now();
    Map<String, dynamic> psetMap = {
      "Experienced?": resultScoreList[1],
      "answeredAt": instantTime,
      "questName": "Pergunta sobre evento traumático",
    };
    databaseMethods.addQuestAnswer(psetMap, userEmail, "Pset");
    if (resultScoreList[1] == 1) {
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pcl5",
        "questName": "PCL-5",
        "availableAt": instantTime,
      };
      DatabaseMethods().createQuest("pcl5", questMap, email);
      DatabaseMethods().disableQuest("pset", email);
    }
  }

  void getUserInfo() async {
    userEmail = await HelperFunctions.getUserEmailInSharedPreference();
    userEmail = userEmail.trim();
    enviarDominios(userEmail);
  }

  PsetResult({this.resultScoreList, this.resultScore});

  /* void _returnMenu(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesScreen.routeName,
    );
  }*/

  final String resultPhrase =
      'Obrigado por responder! \n\nFique atento às próximas atividades.';

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
