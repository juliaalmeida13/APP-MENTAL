import 'package:flutter/material.dart';

class CriticalDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Entre em contato com alguém!'),
      content: const Text(
          'Percebemos que você pode estar em um estado bastante delicado e gostaríamos de sugerir que entre em contato conosco ou com alguém próximo!'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
            Navigator.of(context).pushNamed("/contacts-screen");
          },
          child: const Text('Ok',
              style: TextStyle(color: Color.fromRGBO(104, 202, 138, 1))),
        ),
      ],
    );
  }
}
