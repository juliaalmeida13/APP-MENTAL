import 'package:app_mental/escalas/critical_dialog.dart';
import 'package:app_mental/escalas/recommendation_dialog.dart';
import 'package:app_mental/escalas/success_dialog.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';

class PsqiResult extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  PsqiResult({
    required this.userEmail,
    required this.questName,
    required this.userEscala,
  });

  @override
  State<PsqiResult> createState() => _PsqiResultState();
}

class _PsqiResultState extends State<PsqiResult> {
  bool hasRecommendation = false;
  int score = 0;

  getScore() async {
    int sum = 0;
    await QuestionnaireService()
        .getScore(widget.userEmail, "psqi", widget.userEscala)
        .then((values) {
      for (var i = 5; i < values.length; i++) {
        sum += int.parse(values[i]);
      }
    });
    if (sum != 0) {
      setState(() {
        score = sum;
      });
    }
  }

  verifyScore() {
    if (score > 4) {
      /*Map<String, dynamic> readingsMap1 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono1",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono1", readingsMap1, email);

      Map<String, dynamic> readingsMap2 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono2",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono2", readingsMap2, email);

      Map<String, dynamic> readingsMap3 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono3",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono3", readingsMap3, email);

      Map<String, dynamic> readingsMap4 = {
        "imagePath": "assets/images/sleep01.jpg",
        "title": "Higiene do Sono",
        "readingsId": "sono4",
        "isVideo": false,
      };
      databaseMethods.recomendReading("sono4", readingsMap4, email);*/
      //aparece uma flag no card das leituras e depois na area de higiene do sono pro usuário ir clicando e vai sumir assim que o usuário entrar na leitura

      setState(() {
        hasRecommendation = true;
      });
    }
  }

  isCritical() {
    return score > 10;
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
                verifyScore();
                if (isCritical()) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => CriticalDialog());
                } else if (hasRecommendation) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          RecommendationDialog());
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
