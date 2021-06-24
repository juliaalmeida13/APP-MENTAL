import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/Services/database.dart';
import 'package:flutter/material.dart';
// import './categories_screen.dart';

class Pcl5Result extends StatelessWidget {
  final int resultScoreList;
  final int resultScore;
  String userEmail;
  DateTime instantTime;
  //final Function resetHandler;

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  sendPcl5Score(String email) {
    instantTime = DateTime.now();
    Map<String, dynamic> answerMap = {
      "score": resultScoreList,
      "answeredAt": instantTime,
    };
    databaseMethods.addQuestAnswer(answerMap, email, "pcl5");
  }

  void getUserInfo() async {
    userEmail = await HelperFunctions.getUserEmailInSharedPreference();
    userEmail = userEmail.trim();
    sendPcl5Score(userEmail);
  }

  Pcl5Result({this.resultScoreList, this.resultScore});

  /* void _returnMenu(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesScreen.routeName,
    );
  }*/

  final String resultPhrase =
      'Questionário concluído! \n\nFique atento as próximas atividades.';

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
