import 'package:app_mental/Services/database.dart';
import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:flutter/material.dart';

class Pcl5 extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  final Function resetQuestion;
  final String userEmail;
  final DatabaseMethods databaseMethods = new DatabaseMethods();
  final List<int> resultScoreList;
  final String userEscala;
  final String questName;
  final DateTime now = DateTime.now();

  sendPcl5PartialResult(String email) {
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
      "answeredAt": now,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, userEmail, userEscala);
    databaseMethods.updateQuestIndex(userEscala, userEmail, questionIndex);
  }

  Pcl5({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
    required this.userEmail,
    required this.resultScoreList,
    required this.userEscala,
    required this.questName,
    required this.resetQuestion,
  });

  @override
  Widget build(BuildContext context) {
    var lastIndex = questions.length;
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
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
          ...(questions[questionIndex]['answers'] as List<Map<String, dynamic>>)
              .map((answer) {
            return PromisAnswer(
              () => answerQuestion(answer['score'], answer['index']),
              answer['text']!,
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
                            sendPcl5PartialResult(userEmail);
                            Navigator.pop(context, 'Ok');
                            Navigator.pop(context);
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
