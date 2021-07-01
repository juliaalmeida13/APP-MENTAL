import 'package:chat_app_tutorial/Services/database.dart';
import 'package:chat_app_tutorial/main.dart';
import 'package:flutter/material.dart';
// import './categories_screen.dart';

class Promisn2Result extends StatelessWidget {
  final int resultScore;
  final int questionIndex;
  final String userEmail;
  final String questName;
  final String userEscala;
  final DateTime instantTime = DateTime.now();
  //final Function resetHandler;

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  sendPromisn2Score(String email) {
    Map<String, dynamic> answerMap = {
      "score": resultScore,
      "answeredAt": instantTime,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, email, userEscala);
    databaseMethods.updateQuestIndex(userEscala, email, questionIndex);
    databaseMethods.disableQuest(userEscala, email);
  }

  Promisn2Result({
    this.resultScore,
    this.questionIndex,
    this.userEmail,
    this.questName,
    this.userEscala,
  });

  /* void _returnMenu(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesScreen.routeName,
    );
  }*/

  final String resultPhrase =
      'PROMIS Nível 2 concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

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
              sendPromisn2Score(userEmail);
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
                        await Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => MyApp()));
                        //Navigator.pop(context, 'OK');
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          ),
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
