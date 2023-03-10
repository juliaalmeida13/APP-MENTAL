import 'package:flutter/material.dart';

import '../success_dialog.dart';

class AssistResult extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  AssistResult(
      {required this.userEmail,
      required this.questName,
      required this.userEscala});

  @override
  State<AssistResult> createState() => _AssistResultState();
}

class _AssistResultState extends State<AssistResult> {
  final String resultPhrase =
      'Questionário concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          resultPhrase,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * .03,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(104, 202, 138, 1)),
            child: const Text('Sim, estou de acordo',
                style: TextStyle(color: Colors.black)),
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => SuccessDialog());
            },
          ),
        ),
      ],
    );
  }
}
