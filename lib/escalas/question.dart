import 'package:auto_size_text/auto_size_text.dart';
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
      child: AutoSizeText(
        questionText,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * .018,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
