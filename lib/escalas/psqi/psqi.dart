import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/questForm.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:flutter/material.dart';

class Psqi extends StatelessWidget {
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

  Psqi({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
    required this.resultScoreList,
    required this.userEmail,
    required this.userEscala,
    required this.questName,
    required this.resetQuestion,
  });

  sendPsqiPartialScore(String email) {
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
      "answeredAt": now,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, userEmail, userEscala);
    databaseMethods.updateQuestIndex(userEscala, userEmail, questionIndex);
  }

  isCritical() {
    int sum =
        resultScoreList.fold(0, (previous, current) => previous + current);
    if (sum > 10) {
      return true;
    } else {
      return false;
    }
  }

  hasRecommendation() {
    int sum =
        resultScoreList.fold(0, (previous, current) => previous + current);
    if (sum > 4) {
      return true;
    } else {
      return false;
    }
  }

  var hasForm = false;

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
          Text(""), //spacer was taking too much space 
          hasForm ?
            Column(
              children: [
                Question(
            questions[questionIndex]['questionText'] as String,
          ),
          ...(questions[questionIndex]['answers'] as List<Map<String, dynamic>>)
              .map((answer) {
            return PromisAnswer(
              () => answerQuestion(answer['score']),
              answer['text']!,
            );
          }).toList(),
            ],) :
          QuestForm(() => answerQuestion(2),
              "a"),
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
                            sendPsqiPartialScore(userEmail);
                            if (isCritical()) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      'Entre em contato com alguém!'),
                                  content: const Text(
                                      'Percebemos que você pode estar em um estado bastante delicado e gostaríamos de sugerir que entre em contato conosco ou com alguém próximo!'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context, 'Ok');
                                        await Navigator.of(context).pushNamed(
                                          ContactsScreen.routeName,
                                          arguments: {},
                                        );
                                      },
                                      child: const Text('Ok',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  104, 202, 138, 1))),
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
                                              color: Color.fromRGBO(
                                                  104, 202, 138, 1))),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Navigator.pop(context, 'Ok');
                              Navigator.pop(context, "Ok");
                            }
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