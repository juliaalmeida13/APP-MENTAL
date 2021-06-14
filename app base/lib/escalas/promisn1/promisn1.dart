import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../promis_answer.dart';
import '../question.dart';

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
    // configura os botões
    Widget maisTardeButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          primary: Color.fromRGBO(0, 175, 185, 1)),
      child: Text("Responder mais tarde"),
      onPressed: () {
        var count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
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
            agendarButton,
            cancelarButton,
          ],
        ));
    return Expanded(
      child: Container(
        height: double.infinity,
        margin: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(244, 244, 244, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Question(
              questions[questionIndex]['questionText'],
            ),
            ...(questions[questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map((answer) {
              return PromisAnswer(
                () => answerQuestion(answer['score'], answer['dom']),
                answer['text'],
              );
            }).toList(),
            Spacer(),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(104, 202, 138, 1)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child: const Text('Responder depois',
                    style: TextStyle(color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
