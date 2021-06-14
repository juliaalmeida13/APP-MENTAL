import 'dart:ui';

import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/database.dart';
import 'package:flutter/material.dart';
// import './categories_screen.dart';

class Promisn1Result extends StatelessWidget {
  final List<int> resultScoreList;
  final String questName;
  final String userEscala;
  String userEmail;
  DateTime now = DateTime.now();
  //final Function resetHandler;

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  enviarDominios(String email) {
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
      "answeredAt": now,
      "questName": questName,
    };
    databaseMethods.addQuestAnswer(promisn1Map, userEmail, userEscala);
    if (resultScoreList[1] > 2) {
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pn2",
        "questName": "PROMIS Nível 2",
        "availableAt": now,
        "userEscala": "$userEscala-promisn2",
        "index": 0,
      };
      DatabaseMethods().createQuest("promisN2", questMap, email);
      DatabaseMethods().disableQuest(userEscala, email);
    }
  }

  void getUserInfo() async {
    userEmail = await HelperFunctions.getUserEmailInSharedPreference();
    userEmail = userEmail.trim();
    enviarDominios(userEmail);
  }

  Promisn1Result({this.resultScoreList, this.questName, this.userEscala});

  /* void _returnMenu(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesScreen.routeName,
    );
  }*/

  final String resultPhrase = 'Parabéns por responder ao questionário!!';

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlert(context));

    //getUserInfo();
    return Container(
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
        );
  }

  void showAlert(BuildContext context) {
    Widget voltarButton = TextButton(
      child: Text("Voltar",
          style: TextStyle(color: Color.fromRGBO(0, 175, 185, 1))),
      onPressed: () {
        var count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
      },
    );
    // configura o  Alert
    Widget alert = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text(
            "Parabéns por responder ao questionário!!",
            textAlign: TextAlign.center,
          ),
          content: Image(image: AssetImage('assets/images/unicorn.png')),
          actions: [
            voltarButton,
          ],
        ));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
