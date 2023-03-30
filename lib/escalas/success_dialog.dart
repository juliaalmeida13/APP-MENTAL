import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Êxito!'),
      content: const Text(
          'Suas respostas foram enviadas!\nNovas atividades serão disponibilizadas em breve.'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
            Navigator.of(context).pushNamed("/quests-screen");
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
