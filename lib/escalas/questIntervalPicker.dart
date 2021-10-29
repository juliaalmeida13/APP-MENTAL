import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuestIntervalPicker extends StatefulWidget {
  final Function() selectHandler;
  final String answerText;

  QuestIntervalPicker(this.selectHandler, this.answerText);

  @override
  State<QuestIntervalPicker> createState() => _QuestIntervalPickerState();
}

class _QuestIntervalPickerState extends State<QuestIntervalPicker> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
            decoration: InputDecoration(labelText: "Insira a quantidade em minutos"),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))], 
            ),
          ],
        ),
      );
  }
}
