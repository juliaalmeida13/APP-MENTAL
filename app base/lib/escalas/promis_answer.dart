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
    return ListTile(
      leading: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: Color.fromRGBO(104, 202, 138, 1),
            border: Border.all(color: Color.fromRGBO(88, 161, 114, 1))),
      ),
      title: Text(
        answerText,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      onTap: selectHandler,
    );
  }
}
