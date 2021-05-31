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

  enviarDominios() {
    instantTime = DateTime.now();
    Map<String, dynamic> dominioMap = {
      "dom1": resultScoreList[0],
      "dom2": resultScoreList[1],
      "dom3": resultScoreList[2],
      "dom4": resultScoreList[3],
      "dom5": resultScoreList[4],
      "createdAt": instantTime,
      "questName": "promisn1",
    };
    databaseMethods.addRespostaPromisn1(userEmail, dominioMap);
  }

  void getUserInfo() async {
    userEmail = await HelperFunctions.getUserEmailInSharedPreference();
    enviarDominios();
  }

  Promisn1Result({this.resultScoreList, this.resultScore});

  /* void _returnMenu(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesScreen.routeName,
    );
  }*/

  final String resultPhrase =
      'Questionário concluído! \n\nLogo informaremos as próximas atividades.';

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
