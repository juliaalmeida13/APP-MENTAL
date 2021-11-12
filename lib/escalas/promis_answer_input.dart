import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnswerInput extends StatefulWidget {
  final Function(dynamic) selectHandler;
  final String type;

  AnswerInput(this.selectHandler, this.type);

  @override
  State<AnswerInput> createState() => _AnswerInputState();
}

class _AnswerInputState extends State<AnswerInput> {
  TimeOfDay selectedDate = TimeOfDay.now();

  Future<void> _selectDate(
      BuildContext context, Function(dynamic) selectHandler) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    if (picked != null) {
      selectHandler(formatTimeOfDay(picked));
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm();
    return format.format(dt);
  }

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
    switch (widget.type) {
      case "date":
        return OutlinedButton(
            onPressed: () => _selectDate(context, widget.selectHandler),
            child: Text(
              "Selecionar horário",
            ));
        break;
      default:
        return Text("as");
    }
  }
}
