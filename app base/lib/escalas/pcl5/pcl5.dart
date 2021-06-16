import 'package:flutter/material.dart';

import 'package:chat_app_tutorial/escalas/promis_answer.dart';
import 'package:chat_app_tutorial/escalas/question.dart';

class Pcl5 extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Pcl5(
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
