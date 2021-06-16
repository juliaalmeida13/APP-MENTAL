import 'package:flutter/material.dart';
import 'package:chat_app_tutorial/escalas/question.dart';
import 'package:chat_app_tutorial/escalas/promis_answer.dart';

class Promisn2 extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Promisn2(
      {this.questions,
      @required this.answerQuestion,
      @required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'],
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return PromisAnswer(
            () => answerQuestion(answer['score']),
            answer['text'],
          );
        }).toList()
      ],
    );
  }
}
