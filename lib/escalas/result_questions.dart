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
  bool isLoading = true;
  String finalMessage = "";
  String finalIcon = "";

  @override
  void initState() {
    if (!(widget.questionnaireCode == QuestionnaireCode.questSD1.name ||
        widget.questionnaireCode == QuestionnaireCode.questSD2.name ||
        widget.questionnaireCode == QuestionnaireCode.assist.name ||
        widget.questionnaireCode == QuestionnaireCode.pcl5.name ||
        widget.questionnaireCode == QuestionnaireCode.copsoq.name)) {
      getScoreList().whenComplete(() {
        getScore();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    super.initState();
  }

  getScore() async {
    int sum = 0;
    await QuestionnaireService()
        .getScore(widget.userEmail, widget.questionnaireCode, widget.userEscala)
        .then((values) {
      for (int index = 0; index < values.length; index++) {
        sum += int.parse(values[index]);
      }
    });
    setState(() {
      score = sum;
    });
    getFinalMessage();
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

  isCritical() {
    if (QuestionnaireCode.psqi.name == widget.questionnaireCode) {
      return score > Constants.criticalValuePsqi;
    } else if (QuestionnaireCode.phq9.name == widget.questionnaireCode) {
      return score > Constants.criticalValuePhq9;
    } else if (QuestionnaireCode.ccsm.name == widget.questionnaireCode) {
      //dom 2, 9, 10, 11, 12, leve ou maior (>=2)
      //dom 6, 7 muito leve ou maior (>=1)
      return (scoreList[2] >= 2 ||
          scoreList[11] >= 1 ||
          scoreList[12] >= 1 ||
          scoreList[15] >= 2 ||
          scoreList[16] + scoreList[17] >= 2 ||
          scoreList[18] >= 2 ||
          scoreList[19] + scoreList[20] >= 2);
    } else if (QuestionnaireCode.gad7.name == widget.questionnaireCode) {
      return score > Constants.criticalValueGad7;
    } else if (QuestionnaireCode.phq15.name == widget.questionnaireCode) {
      return score > Constants.criticalValuePhq15;
    } else if (QuestionnaireCode.mdq.name == widget.questionnaireCode) {
      return score > Constants.criticalValueMdq;
    } else if (QuestionnaireCode.assistn2.name == widget.questionnaireCode) {
      return score > Constants.criticalValueAssistN2;
    } else if (QuestionnaireCode.pset.name == widget.questionnaireCode) {
      return score > 0;
    }
    return false;
  }

  getFinalMessage() {
    if (isCritical()) {
      QuestionnaireService()
          .getFinalMessage(widget.questionnaireCode, 0, true)
          .then((value) {
        setState(() {
          finalMessage = value;
          isLoading = false;
          finalIcon = "assets/icons/questionarios_aviso-grave_COR.png";
        });
      });
    } else if (QuestionnaireCode.psqi.name == widget.questionnaireCode &&
            score > 5 ||
        QuestionnaireCode.ccsm.name == widget.questionnaireCode &&
            scoreList[2] >= 2) {
      QuestionnaireService()
          .getFinalMessage(widget.questionnaireCode, 1, false)
          .then((value) {
        setState(() {
          finalMessage = value;
          isLoading = false;
          finalIcon = "assets/icons/questionarios_aviso-moderado_COR.png";
        });
      });
    } else {
      QuestionnaireService()
          .getFinalMessage(widget.questionnaireCode, 0, false)
          .then((value) {
        setState(() {
          finalMessage = value;
          isLoading = false;
          finalIcon = "assets/icons/questionarios_aviso-leve_COR.png";
        });
      });
    }
  }

  showFinalDialog(BuildContext context) {
    if (widget.questionnaireCode == QuestionnaireCode.questSD1.name ||
        widget.questionnaireCode == QuestionnaireCode.questSD2.name ||
        widget.questionnaireCode == QuestionnaireCode.pset.name ||
        widget.questionnaireCode == QuestionnaireCode.assist.name ||
        widget.questionnaireCode == QuestionnaireCode.pcl5.name) {
      showDialog<String>(
          context: context, builder: (BuildContext context) => SuccessDialog());
    } else {
      if (isCritical()) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => CriticalDialog());
      } else {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => SuccessDialog());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          )
        : Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Questionário Respondido!",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .03,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    finalIcon,
                    width: 100,
                    height: 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            finalMessage,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(104, 202, 138, 1)),
                      child: const Text('Ok',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () => showFinalDialog(context),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
