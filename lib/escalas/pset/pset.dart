import 'package:app_mental/Services/database.dart';
import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:flutter/material.dart';

class Pset extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  final String userEmail;
  final DatabaseMethods databaseMethods = new DatabaseMethods();
  final int resultScore;
  final String userEscala;
  final String questName;
  final DateTime now = DateTime.now();

  Pset({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
    required this.userEmail,
    required this.resultScore,
    required this.userEscala,
    required this.questName,
  });

  @override
  Widget build(BuildContext context) {
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
          Question(
            questions[questionIndex]['questionText'] as String,
          ),
          ...(questions[questionIndex]['answers'] as List<Map<String, dynamic>>)
              .map((answer) {
            return AnswerOption(
              () => answerQuestion(answer['score']),
              answer['text'] as String,
            );
          }).toList(),
        ],
      ),
    );
  }
}
