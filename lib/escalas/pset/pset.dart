import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:flutter/material.dart';

class Pset extends StatelessWidget {
  final String question;
  final List<Map<String, Object>> answers;
  final int questionIndex;
  final Function answerQuestion;
  final String userEmail;
  final String scale;

  Pset(
      {required this.answers,
      required this.question,
      required this.answerQuestion,
      required this.questionIndex,
      required this.userEmail,
      required this.scale});

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
          Question(question),
          ...(answers[questionIndex]['answers'] as List<Map<String, dynamic>>)
              .map((answer) {
            return AnswerOption(
              () => answerQuestion(answer['score'], answer['text'], scale),
              answer['text'] as String,
            );
          }).toList(),
        ],
      ),
    );
  }
}
