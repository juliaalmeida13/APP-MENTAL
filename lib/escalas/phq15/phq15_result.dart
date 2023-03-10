import 'package:app_mental/escalas/critical_dialog.dart';
import 'package:app_mental/escalas/success_dialog.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';

class Phq15Result extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  Phq15Result(
      {required this.userEmail,
      required this.questName,
      required this.userEscala});

  @override
  State<Phq15Result> createState() => _Phq15ResultState();
}

class _Phq15ResultState extends State<Phq15Result> {
  int score = 0;

  getScore() async {
    int sum = 0;
    await QuestionnaireService()
        .getScore(widget.userEmail, "phq15", widget.userEscala)
        .then((values) {
      for (var i = 0; i < values.length; i++) {
        sum += int.parse(values[i]);
      }
    });
    if (sum != 0) {
      setState(() {
        score = sum;
      });
    }
  }

  isCritical() {
    return score > 9;
  }

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
              getScore().then((_) {
                if (isCritical()) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => CriticalDialog());
                } else {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => SuccessDialog());
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
