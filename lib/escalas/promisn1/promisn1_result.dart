import 'package:app_mental/Services/questionnaireService.dart';
import 'package:app_mental/escalas/critical_dialog.dart';
import 'package:app_mental/escalas/success_dialog.dart';
import 'package:flutter/material.dart';

class Promisn1Result extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  Promisn1Result(
      {required this.questName,
      required this.userEscala,
      required this.userEmail});

  @override
  State<Promisn1Result> createState() => _Promisn1ResultState();
}

class _Promisn1ResultState extends State<Promisn1Result> {
  final String resultPhrase =
      'PROMIS Nível 1 concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';
  List<int> scoreList = [];

  getScore() async {
    await QuestionnaireService()
        .getScore(widget.userEmail, "pn1", widget.userEscala)
        .then((values) {
      values.forEach((value) {
        scoreList.add(int.parse(value));
      });
    });
  }

  isCritical() {
    //dom 2, 9, 10, 11, 12, leve ou maior (>=2)
    //dom 6, 7 muito leve ou maior (>=1)
    return (scoreList[2] >= 2 ||
        scoreList[11] >= 1 ||
        scoreList[12] >= 1 ||
        scoreList[15] >= 2 ||
        scoreList[16] + scoreList[17] >= 2 ||
        scoreList[18] >= 2 ||
        scoreList[19] + scoreList[20] >= 2);
  }

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
