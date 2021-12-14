import 'package:flutter/material.dart';

// Cria o enunciado da questão, recebendo a penas o texto a ser mostrado.
class Question extends StatelessWidget {
  // Texto do enunciado da questão
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        questionText,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
