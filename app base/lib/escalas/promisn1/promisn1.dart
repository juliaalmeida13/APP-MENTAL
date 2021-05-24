import 'package:flutter/material.dart';
import '../question.dart';
import '../promis_answer.dart';

class Promisn1 extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Promisn1(
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
            () => answerQuestion(answer['score'], answer['dom']),
            answer['text'],
          );
        }).toList()
      ],
    );
  }
}
