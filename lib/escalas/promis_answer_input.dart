import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Em alternativa à AnserOption, cria uma campo para receber uma resposta por input do usuário
// Além da funcão selectHandler ()
// também recebe type para discernir o tipo de input a ser utilizado pela questão

class AnswerInput extends StatefulWidget {
  // Funcão para adiantar o index do quest/escala e salvar o valor da resposta na lista da escala
  final Function(dynamic) selectHandler;

  // Campo para discernir o tipo de input a ser utilizado
  final String type;

  AnswerInput(this.selectHandler, this.type);

  @override
  State<AnswerInput> createState() => _AnswerInputState();
}

class _AnswerInputState extends State<AnswerInput> {
  // Recebe o valor inserido no campo de input e tem o horário atual como padrão
  TimeOfDay selectedDate = TimeOfDay.now();

  // Cria um campo de input para receber Hora e Minuto
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

  // Adiciona Ano, Mês e Dia atuais, e formata o horário que será salvo na escala
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm();
    return format.format(dt);
  }

  @override
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
