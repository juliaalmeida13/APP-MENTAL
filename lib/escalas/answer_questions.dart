import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/promis_answer_input.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/model/answers.dart';
import 'package:flutter/material.dart';

import '../Services/questionnaireService.dart';

class AnswerQuestions extends StatelessWidget {
  final int sizeQuestionnaire;
  final String question;
  final List<Answers> answers;
  final int questionIndex;
  final Function answerQuestion;
  final Function resetQuestion;
  final String userEmail;
  final String scale;
  final String questionnaireCode;
  final String questName;

  AnswerQuestions(
      {required this.answers,
      required this.sizeQuestionnaire,
      required this.question,
      required this.answerQuestion,
      required this.questionIndex,
      required this.resetQuestion,
      required this.userEmail,
      required this.scale,
      required this.questionnaireCode,
      required this.questName});

  String getQuestionText() {
    final startSubstance = questName.split("(");
    final substance = startSubstance[1].split(")");
    final questionText = question + " " + substance[0];
    return questionText;
  }

  goBackToQuestionnaireScreen(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/quests-screen");
  }

  discartChanges(BuildContext context) async {
    QuestionnaireService()
        .discardAllAnswers(userEmail, QuestionnaireCode.ccsm.name, scale)
        .then((_) {
      Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
      Navigator.of(context).pushNamed("/quests-screen");
    });
  }

  answerLater(BuildContext context) {
    return AlertDialog(
      title: const Text('Responder depois'),
      content: const Text(
          'Deseja salvar suas respostas e terminar de responder mais tarde?'),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancelar'),
            ),
            (questionnaireCode == QuestionnaireCode.ccsm.name)
                ? TextButton(
                    onPressed: () => discartChanges(context),
                    child: const Text('Descartar'),
                  )
                : Container(),
            TextButton(
              onPressed: () => goBackToQuestionnaireScreen(context),
              child: const Text('OK'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(244, 244, 244, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .60,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Questão $questionIndex de $sizeQuestionnaire",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        (questionnaireCode == QuestionnaireCode.assistn2.name)
                            ? Question(getQuestionText())
                            : Question(question),
                      ],
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...(answers.map((answer) {
                            return AnswerOption(
                              () => answerQuestion(answer.score, answer.domain,
                                  answer.answerText, scale, questionnaireCode),
                              answer.answerText,
                            );
                          })).toList()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    resetQuestion();
                  },
                  child: const Text("Voltar para a questão anterior"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(104, 202, 138, 1)),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => answerLater(context),
                    );
                  },
                  child: const Text('Responder depois',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
