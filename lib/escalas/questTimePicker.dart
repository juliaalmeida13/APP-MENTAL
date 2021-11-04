import 'package:flutter/material.dart';

class QuestTimePicker extends StatefulWidget {
  final Function() selectHandler;
  final String answerText;

  QuestTimePicker(this.selectHandler, this.answerText);

  @override
  State<QuestTimePicker> createState() => _QuestTimePickerState();
}

class _QuestTimePickerState extends State<QuestTimePicker> {
  Function()? selectHandler;
  String? answerText;
  TimeOfDay selectedTime = TimeOfDay.now();

  
  @override
   void initState() {
  selectHandler = widget.selectHandler;
  answerText = widget.answerText;
  super.initState();
 }
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
            Spacer(),
            OutlinedButton(
              onPressed: selectHandler,
              child: Text(
                "Confirmar",
                textAlign: TextAlign.center,
              ),
            style: new ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(12))),
              )
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
