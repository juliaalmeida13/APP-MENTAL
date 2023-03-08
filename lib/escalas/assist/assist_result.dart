import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';
import '../../Services/scaleService.dart';

class AssistResult extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  AssistResult(
      {required this.userEmail,
      required this.questName,
      required this.userEscala});

  @override
  State<AssistResult> createState() => _AssistResultState();
}

class _AssistResultState extends State<AssistResult> {
  List<int> scoreList = [];
  String week = "";

  @override
  void initState() {
    getWeek();
    super.initState();
  }

  getScore() async {
    await QuestionnaireService()
        .getScore(widget.userEmail, "assist", widget.userEscala)
        .then((values) {
      values.forEach((value) {
        scoreList.add(int.parse(value));
      });
    });
  }

  getWeek() {
    List<String> monthWeek = widget.questName.split("- ");
    setState(() {
      week = monthWeek[1];
    });
  }

  verifyScore() {
    if (scoreList[1] == 1) {
      ScaleService().createScale(
          widget.userEmail,
          "(derivados do tabaco) - $week ",
          "${widget.userEscala}-assistN2-tabaco",
          "assistn2");
    }
    if (scoreList[2] == 1) {
      ScaleService().createScale(
          widget.userEmail,
          "(bebidas alcoólicas) - $week ",
          "${widget.userEscala}-assistN2-alcool",
          "assistn2");
    }
    if (scoreList[3] == 1) {
      ScaleService().createScale(widget.userEmail, "(maconha) - $week ",
          "${widget.userEscala}-assistN2-maconha", "assistn2");
    }
    if (scoreList[4] == 1) {
      ScaleService().createScale(widget.userEmail, "(cocaína, crack) - $week ",
          "${widget.userEscala}-assistN2-crack", "assistn2");
    }
    if (scoreList[5] == 1) {
      ScaleService().createScale(
          widget.userEmail,
          "(anfetaminas ou êxtase) - $week ",
          "${widget.userEscala}-assistN2-anf",
          "assistn2");
    }
    if (scoreList[6] == 1) {
      ScaleService().createScale(widget.userEmail, "(inalantes) - $week ",
          "${widget.userEscala}-assistN2-inalantes", "assistn2");
    }
    if (scoreList[7] == 1) {
      ScaleService().createScale(
          widget.userEmail,
          "(hipnóticos ou sedativos) - $week ",
          "${widget.userEscala}-assistN2-hipno",
          "assistn2");
    }
    if (scoreList[8] == 1) {
      ScaleService().createScale(widget.userEmail, "(alucinógenos) - $week ",
          "${widget.userEscala}-assistN2-aluci", "assistn2");
    }
    if (scoreList[8] == 1) {
      ScaleService().createScale(widget.userEmail, "(opioides) - $week ",
          "${widget.userEscala}-assistN2-opio", "assistn2");
    }
    if (scoreList[8] == 1) {
      ScaleService().createScale(
          widget.userEmail,
          "(outras substâncias) - $week ",
          "${widget.userEscala}-assistN2-outros",
          "assistn2");
    }
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
              });
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Êxito!'),
                  content: const Text(
                      'Suas respostas foram enviadas!\nNovas atividades serão disponibilizadas em breve.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/logged-home'));
                        Navigator.of(context).pushNamed("/quests-screen");
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
