import 'package:flutter/material.dart';

class RecommendationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Recomendações para você!'),
      content: const Text(
          'Seguindo uma análise rápida das suas respostas, algumas leituras ou vídeos foram recomendadas para você, e estarão disponíveis em sua tela inicial!'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Ok');
            await Navigator.pushReplacementNamed(
              context,
              "/logged-home",
              arguments: {},
            );
          },
          child: const Text('Ok',
              style: TextStyle(color: Color.fromRGBO(104, 202, 138, 1))),
        ),
      ],
    );
  }
}
