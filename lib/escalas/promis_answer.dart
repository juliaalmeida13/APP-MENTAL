import 'package:flutter/material.dart';

import '../helper/util.dart';

class AnswerOption extends StatefulWidget {
  final Function() selectHandler;
  final String answerText;
  final String scale;
  final int questionIndex;
  final bool checkboxValue;
  final Function checkboxHandler;
  final int index;

  AnswerOption(this.selectHandler, this.answerText, this.scale,
      this.questionIndex, this.checkboxValue, this.checkboxHandler, this.index);

  @override
  State<AnswerOption> createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  Widget getNormalButton() {
    return OutlinedButton(
      onPressed: widget.selectHandler,
      child: Text(
        widget.answerText,
        textAlign: TextAlign.center,
      ),
      style: new ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(12))),
    );
  }

  Widget getCheckboxButton() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            side: BorderSide(color: Colors.blue),
            value: widget.checkboxValue,
            activeColor: Colors.blue,
            onChanged: (newValue) =>
                widget.checkboxHandler(newValue, widget.index),
          ),
          Text(
            widget.answerText,
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (isCopsoqAndCheckboxQuestion(widget.scale, widget.questionIndex))
        ? getCheckboxButton()
        : getNormalButton();
  }
}
