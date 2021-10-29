import 'package:flutter/material.dart';

class QuestForm extends StatefulWidget {
  final Function() selectHandler;
  final String answerText;

  QuestForm(this.selectHandler, this.answerText);

  @override
  State<QuestForm> createState() => _QuestFormState();
}

class _QuestFormState extends State<QuestForm> {
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
              child: Text("Selecione seu horário"),
            ),
            Text("${selectedTime.hour}:${selectedTime.minute}"),
          ],
        ),
      );
  }

  _selectTime(BuildContext context) async {
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.input,
        confirmText: "CONFIRMAR",
        cancelText: "MAIS TARDE",
          helpText: "SELECIONE SEU HORÁRIO",
 
      );
      if(timeOfDay != null && timeOfDay != selectedTime)
        {
          setState(() {
            selectedTime = timeOfDay;
          });
        }
  }
}
