import 'dart:ui';

import 'package:app_mental/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:app_mental/Services/database.dart';

class Promisn1 extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  final Function resetLastDomain;
  final String userEmail;
  final DatabaseMethods databaseMethods = new DatabaseMethods();
  final List<int> resultScoreList;
  final String userEscala;
  final String questName;
  final DateTime now = DateTime.now();

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
      "answeredUntil": questionIndex,
    };
    print("EnviarDominios userEmail/userEscala");
    print(userEmail);
    print(userEscala);
    databaseMethods.addQuestAnswer(promisn1Map, userEmail, userEscala);
    databaseMethods.updateQuestIndex(userEscala, userEmail, questionIndex);
  }

  Promisn1({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
    required this.userEmail,
    required this.resultScoreList,
    required this.userEscala,
    required this.questName,
    required this.resetLastDomain,
  });

  @override
  Widget build(BuildContext context) {
    // configura os botões
    Widget maisTardeButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          primary: Color.fromRGBO(0, 175, 185, 1)),
      child: Text("Responder mais tarde"),
      onPressed: () {
        enviarDominios(userEmail);
        var count = 0;
        /*Navigator.popUntil(context, (route) {
          return count++ == 2;
        });*/
        Navigator.popUntil(context, ModalRoute.withName('/quests-screen'));
      },
    );
    Widget agendarButton = TextButton(
      child: Text(
        "Agendar um lembrete",
        style: TextStyle(color: Color.fromRGBO(0, 175, 185, 1)),
      ),
      onPressed: () {},
    );
    Widget cancelarButton = TextButton(
      child: Text("Cancelar",
          style: TextStyle(color: Color.fromRGBO(0, 175, 185, 1))),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // configura o  Alert
    Widget alert = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text(
            "Gostaria de responder mais tarde?",
            textAlign: TextAlign.center,
          ),
          actions: [
            maisTardeButton,
            //agendarButton,
            //cancelarButton,
          ],
        ));
    var currentAnswer =
        questions[questionIndex]['answers'] as List<Map<String, Object>>;
    var currentDom = currentAnswer[0]['dom'];
    var lastAnswer =
        questions[questions.length - 1]['answers'] as List<Map<String, Object>>;
    var lastDom = lastAnswer[0]['dom'];
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: 15, left: 15, right:15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(244, 244, 244, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Domínio $currentDom de $lastDom",
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Question(
            questions[questionIndex]['questionText'] as String,
          ),
          ...(questions[questionIndex]['answers'] as List<Map<String, dynamic>>)
              .map((answer) {
            return PromisAnswer(
              () => answerQuestion(answer['score'], answer['dom']),
              answer['text']!,
            );
          }).toList(),
          Spacer(),
          Container(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    var answer = questions[questionIndex]['answers']
                        as List<Map<String, Object>>;
                    resetLastDomain(answer[0]['dom']);
                  },
                  child: const Text("Responder de novo este domínio"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(104, 202, 138, 1)),
                  /*onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                    },*/
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Responder depois'),
                      content: const Text(
                          'Deseja salvar suas respostas e terminar de responder mais tarde?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context, 'Ok');
                            await Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (context) => MyApp()));
                            //Navigator.pop(context, 'OK');
                          },
                          child: const Text('Descartar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            enviarDominios(userEmail);
                            Navigator.pop(context, 'Ok');
                            await Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (context) => MyApp()));
                            //Navigator.pop(context, 'OK');
                          },
                          child: const Text('Salvar'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Responder depois',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
