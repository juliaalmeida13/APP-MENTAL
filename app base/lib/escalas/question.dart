import 'package:flutter/material.dart';

class Question extends StatelessWidget {
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
