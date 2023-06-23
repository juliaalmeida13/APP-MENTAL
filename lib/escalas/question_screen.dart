import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';
import '../../model/questionnaire_answer.dart';
import '../model/answers.dart';
import './answer_questions.dart';
import './result_questions.dart';

class QuestionScreen extends StatefulWidget {
  static const routeName = '/question-screen';

  @override
  _QuestionScreenState createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  late String userEmail;
  bool userHasStartedAnswer = false;
  bool isLoading = false;
  int questionsSize = 0;

  @override
  void initState() {
    getUserEmail();
    super.initState();
  }

  getUserEmail() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((value) {
      setState(() {
        userEmail = value;
      });
    });
  }

  var _questionIndex = 0;

  void _answerQuestion(Object score, int domain, String answer, String scale,
      String questionnaireCode) {
    if (questionnaireCode == "quesi" && answer == "Não") {
      Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
      Navigator.of(context).pushNamed("/quests-screen");
    } else {
      QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
          email: userEmail,
          answer: answer,
          score: score,
          domain: domain,
          code: questionnaireCode,
          questionIndex: _questionIndex,
          scale: scale);
      if (_questionIndex + 1 == questionsSize) {
        setState(() {
          isLoading = true;
        });
        QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer).then(
              (_) => {
                setState(() {
                  _questionIndex += 1;
                  isLoading = false;
                }),
              },
            );
      } else {
        QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
        setState(() {
          _questionIndex += 1;
        });
      }
    }
  }

  void _resetQuestion() {
    setState(() {
      _questionIndex -= 1;
    });
  }

  getAnswers(answers, questionIndex) {
    List<Answers> answersList = [];
    for (int i = 0; i < answers.length; i++) {
      if (answers[i].order == _questionIndex) {
        answersList.add(answers[i]);
      }
    }
    return answersList;
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final titleAA = routeArgs['title'];
    final _userEscala = routeArgs["userEscala"];
    final _answeredUntil = routeArgs['answeredUntil'];
    final _userEmail = routeArgs['email'];
    final _questions = routeArgs['questions'];
    final _questionnaireCode = routeArgs['questionnaireCode'];
    final _answers = routeArgs['answers'];

    if (_answeredUntil > 0 && _questionIndex == 0 && !userHasStartedAnswer) {
      _questionIndex = _answeredUntil;
      setState(() {
        userHasStartedAnswer = true;
      });
    } else if (_questionIndex < 0) {
      _questionIndex = 0;
    }

    setState(() {
      questionsSize = _questions.length;
    });

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(titleAA!)),
        backgroundColor: kTextColorGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: isLoading
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
            : _questionIndex < _questions.length
                ? AnswerQuestions(
                    questName: titleAA,
                    sizeQuestionnaire: _questions.length - 1,
                    answerQuestion: _answerQuestion,
                    resetQuestion: _resetQuestion,
                    questionIndex: _questionIndex,
                    question: _questions[_questionIndex],
                    answers: getAnswers(_answers, _questionIndex),
                    userEmail: _userEmail,
                    scale: _userEscala,
                    questionnaireCode: _questionnaireCode)
                : ResultQuestions(
                    questionnaireCode: _questionnaireCode,
                    questName: titleAA,
                    userEscala: _userEscala!,
                    userEmail: _userEmail),
      ),
    );
  }
}
