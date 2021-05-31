import 'package:flutter/material.dart';

class PromisAnswer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  PromisAnswer(this.selectHandler, this.answerText);

  @override
  /*Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(answerText),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: selectHandler,
      ),
    );
  }*/

  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
              title: Text(answerText),
              onTap: selectHandler,
            ),
            Divider(thickness: 2.0),
          ],
        ));
  }
}
