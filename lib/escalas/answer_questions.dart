import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/model/answers.dart';
import 'package:flutter/material.dart';

import '../Services/questionnaireService.dart';
import '../helper/util.dart';
import '../model/questionnaire_answer.dart';

class AnswerQuestions extends StatefulWidget {
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
  final Function setQuestionIndex;
  final bool required;

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
      required this.questName,
      required this.setQuestionIndex,
      required this.required});

  @override
  State<AnswerQuestions> createState() => _AnswerQuestionsState();
}

class _AnswerQuestionsState extends State<AnswerQuestions> {
  List<bool> checkboxValueList = [false, false, false, false, false, false];
  final textController = TextEditingController();
  final telNumberController = TextEditingController();
  var showRequiredError = false;
  TimeOfDay timeOfDay = TimeOfDay(hour: 0, minute: 0);

  changeCheckboxValue(newValue, index) {
    setState(() {
      checkboxValueList[index] = newValue!;
    });
  }

  String getQuestionText() {
    if (widget.questionnaireCode == QuestionnaireCode.assistn2.name) {
      final startSubstance =
          widget.questName.substring(widget.questName.indexOf("(") + 1);
      final substance =
          startSubstance.substring(0, startSubstance.lastIndexOf(")"));
      final questionText = widget.question + " " + substance;
      return questionText;
    } else {
      if (widget.questionnaireCode == QuestionnaireCode.pset.name &&
          widget.scale == "pset_week2") {
        return "Durante sua vida " + widget.question;
      } else {
        return "No último mês " + widget.question;
      }
    }
  }

  goBackToQuestionnaireScreen(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/quests-screen");
  }

  discartChanges(BuildContext context) async {
    QuestionnaireService()
        .discardAllAnswers(
            widget.userEmail, QuestionnaireCode.ccsm.name, widget.scale)
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
            (widget.questionnaireCode == QuestionnaireCode.ccsm.name)
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

  sendAllChosenCheckboxes(index) {
    for (int i = 0; i < checkboxValueList.length; i++) {
      if (checkboxValueList[i]) {
        QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
            answerId: widget.answers[i].answerId,
            email: widget.userEmail,
            answer: widget.answers[i].answerText,
            score: widget.answers[i].score,
            domain: widget.answers[i].domain,
            code: widget.questionnaireCode,
            questionIndex: widget.questionIndex,
            scale: widget.scale);
        QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
        setState(() {
          checkboxValueList[i] = false;
        });
      }
    }
    QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
        answerId: widget.answers[index].answerId,
        email: widget.userEmail,
        answer: widget.answers[index].answerText,
        score: widget.answers[index].score,
        domain: widget.answers[index].domain,
        code: widget.questionnaireCode,
        questionIndex: widget.questionIndex,
        scale: widget.scale);
    QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
    widget.setQuestionIndex(widget.questionIndex + 1);
  }

  sendText() {
    if (textController.text.isEmpty) {
      if (widget.required) {
        this.showRequiredError = true;
        return;
      }
      textController.text = "Continuar";
    }
    this.showRequiredError = false;
    QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
        answerId: widget.answers[0].answerId,
        email: widget.userEmail,
        answer: textController.text,
        score: textController.text,
        domain: widget.answers[0].domain,
        code: widget.questionnaireCode,
        questionIndex: widget.questionIndex,
        scale: widget.scale);
    QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
    widget.setQuestionIndex(widget.questionIndex + 1);
    textController.text = "";
    telNumberController.text = "";
  }

  sendEmergencyContact() {
    if ((widget.required) &&
        (textController.text.isEmpty || telNumberController.text.isEmpty)) {
      this.showRequiredError = true;
      return;
    }
    QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
        answerId: widget.answers[0].answerId,
        email: widget.userEmail,
        answer: "${textController.text}/${telNumberController.text}",
        score: "${textController.text}/${telNumberController.text}",
        domain: widget.answers[0].domain,
        code: widget.questionnaireCode,
        questionIndex: widget.questionIndex,
        scale: widget.scale);
    QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
    widget.setQuestionIndex(widget.questionIndex + 1);
    textController.text = "";
    telNumberController.text = "";
  }

  sendTime() {
    QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
        answerId: widget.answers[0].answerId,
        email: widget.userEmail,
        answer: textController.text,
        score: textController.text,
        domain: widget.answers[0].domain,
        code: widget.questionnaireCode,
        questionIndex: widget.questionIndex,
        scale: widget.scale);
    QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
    widget.setQuestionIndex(widget.questionIndex + 1);
    textController.text = "";
  }

  List<Widget> getListAnswers() {
    if (widget.scale == "copsoq_week2" && widget.questionIndex == 45) {
      return [
        Column(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 4,
              controller: textController,
              maxLength: 100,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: sendText,
              child: Text(
                "Continuar",
                textAlign: TextAlign.center,
              ),
              style: new ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12))),
            ),
          ),
        ]),
      ];
    } else if (isCheckboxQuestion(
        widget.questionnaireCode, widget.questionIndex)) {
      return [
        ...(widget.answers.map((answer) {
          int index = widget.answers.indexOf(answer);
          if (answer.answerText == "Continuar") {
            return OutlinedButton(
              onPressed: () => sendAllChosenCheckboxes(index),
              child: Text(
                answer.answerText,
                textAlign: TextAlign.center,
              ),
              style: new ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12))),
            );
          }
          return AnswerOption(
            () => widget.answerQuestion(
                answer.answerId,
                answer.score,
                answer.domain,
                answer.answerText,
                widget.scale,
                widget.questionnaireCode),
            answer.answerText,
            widget.scale,
            widget.questionnaireCode,
            widget.questionIndex,
            checkboxValueList[index],
            changeCheckboxValue,
            index,
          );
        })).toList(),
      ];
    } else if (widget.questionnaireCode == "psqi" &&
        (widget.questionIndex == 1 ||
            widget.questionIndex == 3 ||
            widget.questionIndex == 4)) {
      return [
        Column(children: [
          Padding(
              padding: EdgeInsets.all(15.0),
              child: textController.text.isNotEmpty
                  ? Text(
                      "Hora selecionada: ${textController.text}H",
                      style: TextStyle(fontSize: 16),
                    )
                  : null),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                timeOfDay =
                    await selectTime(context, "Por favor, coloque o horário");
                setState(() {
                  textController.text = timeOfDay.format(context);
                });
              },
              child: Text(
                "Selecionar hora",
                textAlign: TextAlign.center,
              ),
              style: new ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12))),
            ),
          ),
          textController.text.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: sendTime,
                    child: Text(
                      "Continuar",
                      textAlign: TextAlign.center,
                    ),
                    style: new ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(12))),
                  ),
                )
              : Container()
        ]),
      ];
    } else if (widget.questionnaireCode == "questSD1" &&
        (widget.questionIndex == 1 ||
            widget.questionIndex == 2 ||
            widget.questionIndex == 7 ||
            widget.questionIndex == 13)) {
      return [
        Column(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 1,
              controller: textController,
              maxLength: widget.questionIndex == 7 ? 3 : 100,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: sendText,
              child: Text(
                "Continuar",
                textAlign: TextAlign.center,
              ),
              style: new ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12))),
            ),
          )
        ]),
      ];
    } else if (widget.questionnaireCode == "questSD1" &&
        widget.questionIndex == 8) {
      return [
        Column(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Nome do contato de emergência",
              ),
              maxLines: 1,
              controller: textController,
              maxLength: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Telefone",
              ),
              maxLines: 1,
              controller: telNumberController,
              maxLength: 20,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: sendEmergencyContact,
              child: Text(
                "Continuar",
                textAlign: TextAlign.center,
              ),
              style: new ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12))),
            ),
          ),
          (this.showRequiredError)
              ? Text("O campo é obrigatório!")
              : (Container())
        ]),
      ];
    } else {
      return [
        ...(widget.answers.map((answer) {
          return AnswerOption(
            () => widget.answerQuestion(
                answer.answerId,
                answer.score,
                answer.domain,
                answer.answerText,
                widget.scale,
                widget.questionnaireCode),
            answer.answerText,
            widget.scale,
            widget.questionnaireCode,
            widget.questionIndex,
            checkboxValueList[0],
            changeCheckboxValue,
            0,
          );
        })).toList(),
      ];
    }
  }

  isAssistn2OrPset() {
    return widget.questionnaireCode == QuestionnaireCode.assistn2.name ||
        widget.questionnaireCode == QuestionnaireCode.pset.name;
  }

  Future<TimeOfDay> selectTime(BuildContext context, String text) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      helpText: text,
      initialTime: TimeOfDay(hour: 0, minute: 0),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!);
      },
    );
    if (result != null) {
      return result;
    } else {
      return TimeOfDay(hour: 0, minute: 0);
    }
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
      child: SingleChildScrollView(
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
                            "Questão ${widget.questionIndex} de ${widget.sizeQuestionnaire}",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          isAssistn2OrPset()
                              ? Question(getQuestionText())
                              : Question(widget.question),
                        ],
                      ),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: getListAnswers(),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(104, 202, 138, 1)),
                    onPressed: () {
                      widget.resetQuestion();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/questionarios_responder-depois.png",
                          width: 40,
                          height: 40,
                        ),
                        const Text(
                          "Voltar para a questão anterior",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/questionarios_responder-agora.png",
                          width: 40,
                          height: 40,
                        ),
                        const Text('Responder depois',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
