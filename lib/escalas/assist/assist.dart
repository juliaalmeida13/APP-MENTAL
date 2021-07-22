import 'package:app_mental/Services/database.dart';
import 'package:app_mental/main.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:app_mental/escalas/promis_answer.dart';

class Assist extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final List<int> resultScoreList;
  final Function answerQuestion;
  final Function resetQuestion;
  final String userEmail;
  final String userEscala;
  final String questName;
  final DatabaseMethods databaseMethods = new DatabaseMethods();
  final DateTime now = DateTime.now();

  Assist({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
    required this.resultScoreList,
    required this.userEmail,
    required this.userEscala,
    required this.questName,
    required this.resetQuestion,
  });

  sendAssistPartialScore(String email) {
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
      "answeredAt": now,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, userEmail, userEscala);
    databaseMethods.updateQuestIndex(userEscala, userEmail, questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var lastIndex = questions.length + 1;
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(top: 6, left: 2, right: 2, bottom: 2),
      padding: EdgeInsets.only(top: 6, left: 2, right: 2, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(244, 244, 244, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Questão ${questionIndex + 1} de $lastIndex",
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Question(
            questions[questionIndex]['questionText'] as String,
          ),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            return PromisAnswer(
              () => answerQuestion(answer['score']),
              answer['text'] as String,
            );
          }).toList(),
          Spacer(),
          Container(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    resetQuestion();
                  },
                  child: const Text("Voltar para a questão anterior"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(104, 202, 138, 1)),
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
                            sendAssistPartialScore(userEmail);
                            Navigator.pop(context, 'Ok');
                            await Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          },
                          child: const Text('OK'),
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
