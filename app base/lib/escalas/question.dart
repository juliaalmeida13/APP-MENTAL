import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: Text(
        questionText,
        style: TextStyle(
          fontSize: 22,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
