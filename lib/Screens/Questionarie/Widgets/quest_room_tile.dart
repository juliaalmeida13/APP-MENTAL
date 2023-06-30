import 'package:flutter/material.dart';

import '../../../Services/questionnaireService.dart';
import '../../../escalas/question_screen.dart';
import '../../../model/answers.dart';
import 'quiz_card.dart';

class QuestRoomTile extends StatelessWidget {
  final String questName;
  final String questCode;
  final DateTime availableAt;
  final String userEscala;
  final int answeredUntil;
  final bool unanswered;
  final String week;
  final DateTime answeredAt;
  final String userEmail;
  final DateTime _now = DateTime.now();

  QuestRoomTile(
      this.questName,
      this.questCode,
      this.availableAt,
      this.userEscala,
      this.answeredUntil,
      this.unanswered,
      this.week,
      this.answeredAt,
      this.userEmail);

  @override
  Widget build(BuildContext context) {
    // Caso a escala/questionário seja planejada para a semana atual, constroi-se um card
    if (_now.isAfter(availableAt) &&
        unanswered == true &&
        questCode != "sleepQuestionnaire") {
      return QuizCard(
          notificationStatus: unanswered,
          title: "$questName - $week",
          completed: "Questões respondidas: $answeredUntil",
          answeredAt: answeredAt,
          onTap: () async {
            if (unanswered) {
              List<dynamic> _questions = [];
              List<Answers> _answers = [];
              await QuestionnaireService().getAnswers(questCode).then((values) {
                _answers = values;
              }).whenComplete(() => {
                    QuestionnaireService().getQuestions(questCode).then(
                        (values) {
                      values.forEach((value) {
                        _questions.add(value);
                      });
                    }).whenComplete(() => Navigator.of(context)
                            .pushNamed(QuestionScreen.routeName, arguments: {
                          'title': "$questName - $week",
                          'userEscala': userEscala,
                          'answeredUntil': answeredUntil,
                          'email': userEmail,
                          'questions': _questions,
                          'questionnaireCode': questCode,
                          'answers': _answers
                        }))
                  });
            }
          });
    } else if (questCode == "sleepQuestionnaire") {
      if (unanswered == true) {
        return QuizCard(
          notificationStatus: unanswered,
          title: questName,
          completed: "Não respondido!",
          answeredAt: answeredAt,
          onTap: () {
            if (unanswered) {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName('/logged-home'));
              Navigator.of(context).pushNamed("/sleep-diary");
            }
          },
        );
      } else {
        return QuizCard(
            notificationStatus: unanswered,
            title: questName,
            completed: "Respondido!",
            answeredAt: answeredAt,
            onTap: () {});
      }
    } else if (unanswered == false) {
      return QuizCard(
          notificationStatus: unanswered,
          title: "$questName - $week",
          completed: "Respondido!",
          answeredAt: answeredAt,
          onTap: () {});
    } else {
      return Container();
    }
  }
}
