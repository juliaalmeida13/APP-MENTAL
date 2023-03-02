import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:flutter/material.dart';

class QuestSD1 extends StatelessWidget {
  final int sizeQuestionnaire;
  final String question;
  final List<Map<String, Object>> answers;
  final int questionIndex;
  final Function answerQuestion;
  final Function resetQuestion;

  QuestSD1({
    required this.answers,
    required this.sizeQuestionnaire,
    required this.question,
    required this.answerQuestion,
    required this.questionIndex,
    required this.resetQuestion,
  });

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              "Questão $questionIndex de $sizeQuestionnaire",
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            flex: 1,
            child: Divider(),
          ),
          Flexible(
            flex: 3,
            child: Question(question),
          ),
          Flexible(
            flex: 7,
            child: ListView(
              children: [
                ...(answers[questionIndex]['answers']
                        as List<Map<String, dynamic>>)
                    .map((answer) {
                  return AnswerOption(
                    () => answerQuestion(answer['score'], answer['text']),
                    answer['text']!,
                  );
                }).toList(),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
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
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Responder depois'),
                        content: const Text(
                            'Deseja salvar suas respostas e terminar de responder mais tarde?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).popUntil(
                                  ModalRoute.withName('/logged-home'));
                              Navigator.of(context).pushNamed("/quests-screen");
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    child: const Text('Responder depois',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
