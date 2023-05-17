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
      for (var index = 0; index < values.length; index++) {
        sum += int.parse(values[index]);
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
      setState(() {
        hasRecommendation = true;
      });
    }
    if (QuestionnaireCode.assistn2.name == widget.questionnaireCode &&
        score > Constants.recommendationValueAssistN2) {
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
