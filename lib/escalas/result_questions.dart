import 'package:app_mental/escalas/recommendation_dialog.dart';
import 'package:app_mental/escalas/success_dialog.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:flutter/material.dart';

import '../Services/questionnaireService.dart';
import 'critical_dialog.dart';

class ResultQuestions extends StatefulWidget {
  final String questionnaireCode;
  final String userEmail;
  final String questName;
  final String userEscala;

  ResultQuestions(
      {required this.questionnaireCode,
      required this.userEmail,
      required this.questName,
      required this.userEscala});

  @override
  State<ResultQuestions> createState() => _ResultQuestionsState();
}

class _ResultQuestionsState extends State<ResultQuestions> {
  bool hasRecommendation = false;
  int score = 0;
  List<int> scoreList = [];

  final String resultPhrase =
      'Questionário concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

  getScore() async {
    int sum = 0;
    await QuestionnaireService()
        .getScore(widget.userEmail, widget.questionnaireCode, widget.userEscala)
        .then((values) {
      if (widget.questionnaireCode == "psqi") {
        for (var index = Constants.startingPsqiValue;
            index < values.length;
            index++) {
          sum += int.parse(values[index]);
        }
      } else {
        for (var index = 0; index < values.length; index++) {
          sum += int.parse(values[index]);
        }
      }
    });
    setState(() {
      score = sum;
    });
  }

  getScoreList() async {
    await QuestionnaireService()
        .getScore(widget.userEmail, widget.questionnaireCode, widget.userEscala)
        .then((values) {
      values.forEach((value) {
        scoreList.add(int.parse(value));
      });
    });
  }

  verifyScore() {
    if (QuestionnaireCode.psqi.name == widget.questionnaireCode &&
        score > Constants.recommendationValuePsqi) {
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
    if (QuestionnaireCode.assistn2.name == widget.questionnaireCode &&
        score > Constants.recommendationValueAssistN2) {
      /*Map<String, dynamic> readingsMap1 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce1",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce1", readingsMap1, email);

      Map<String, dynamic> readingsMap2 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce2",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce2", readingsMap2, email);

      Map<String, dynamic> readingsMap3 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce3",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce3", readingsMap3, email);

      Map<String, dynamic> readingsMap4 = {
        "imagePath": "assets/images/care01.jpg",
        "title": "Redução de Danos",
        "readingsId": "reduce4",
        "isVideo": false,
      };
      databaseMethods.recomendReading("reduce4", readingsMap4, email);*/
      setState(() {
        hasRecommendation = true;
      });
    }
  }

  isCritical() {
    if (QuestionnaireCode.psqi.name == widget.questionnaireCode) {
      return score > Constants.criticalValuePsqi;
    } else if (QuestionnaireCode.pn2.name == widget.questionnaireCode) {
      return score > Constants.criticalValuePromisN2;
    } else if (QuestionnaireCode.pn1.name == widget.questionnaireCode) {
      //dom 2, 9, 10, 11, 12, leve ou maior (>=2)
      //dom 6, 7 muito leve ou maior (>=1)
      return (scoreList[2] >= 2 ||
          scoreList[11] >= 1 ||
          scoreList[12] >= 1 ||
          scoreList[15] >= 2 ||
          scoreList[16] + scoreList[17] >= 2 ||
          scoreList[18] >= 2 ||
          scoreList[19] + scoreList[20] >= 2);
    } else if (QuestionnaireCode.pn2A.name == widget.questionnaireCode) {
      return score > Constants.criticalValuePromisAnsi;
    } else if (QuestionnaireCode.phq15.name == widget.questionnaireCode) {
      return score > Constants.criticalValuePhq15;
    } else if (QuestionnaireCode.mdq.name == widget.questionnaireCode) {
      return score > Constants.criticalValueMdq;
    } else if (QuestionnaireCode.assistn2.name == widget.questionnaireCode) {
      return score > Constants.criticalValueAssistN2;
    }
    return false;
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
              if (widget.questionnaireCode == QuestionnaireCode.questSD1.name ||
                  widget.questionnaireCode == QuestionnaireCode.questSD2.name ||
                  widget.questionnaireCode == QuestionnaireCode.pset.name ||
                  widget.questionnaireCode == QuestionnaireCode.assist.name ||
                  widget.questionnaireCode == QuestionnaireCode.pcl5.name) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => SuccessDialog());
              } else if (widget.questionnaireCode ==
                  QuestionnaireCode.pn1.name) {
                getScoreList().then((_) {
                  verifyScore();
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
              } else {
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
              }
            },
          ),
        ),
      ],
    );
  }
}
