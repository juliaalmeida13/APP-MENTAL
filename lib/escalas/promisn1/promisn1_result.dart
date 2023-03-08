import 'package:app_mental/Services/questionnaireService.dart';
import 'package:app_mental/Services/scaleService.dart';
import 'package:flutter/material.dart';

class Promisn1Result extends StatefulWidget {
  final String userEmail;
  final String questName;
  final String userEscala;

  Promisn1Result(
      {required this.questName,
      required this.userEscala,
      required this.userEmail});

  @override
  State<Promisn1Result> createState() => _Promisn1ResultState();
}

class _Promisn1ResultState extends State<Promisn1Result> {
  final String resultPhrase =
      'PROMIS Nível 1 concluído! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';
  List<int> scoreList = [];
  String week = "";

  @override
  void initState() {
    getWeek();
    super.initState();
  }

  getScore() async {
    await QuestionnaireService()
        .getScore(widget.userEmail, "pn1", widget.userEscala)
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

  verifyScore() async {
    if (scoreList[1] + scoreList[2] >= 2) {
      ScaleService().createScale(
          widget.userEmail, week, "${widget.userEscala}-PromisN2", "pn2");
    }
    if (scoreList[4] + scoreList[5] >= 2) {
      ScaleService().createScale(
          widget.userEmail, week, "${widget.userEscala}-Mdq", "mdq");
    }
    if (scoreList[6] + scoreList[7] + scoreList[8] >= 2) {
      ScaleService().createScale(
          widget.userEmail, week, "${widget.userEscala}-PromisAnsi", "pn2A");
    }
    if (scoreList[9] + scoreList[10] >= 2) {
      ScaleService().createScale(
          widget.userEmail, week, "${widget.userEscala}-Phq15", "phq15");
    }
    if (scoreList[14] >= 2) {
      ScaleService().createScale(
          widget.userEmail, week, "${widget.userEscala}-Psqi", "psqi");
    }
    if (scoreList[21] + scoreList[22] + scoreList[23] >= 1) {
      ScaleService().createScale(
          widget.userEmail, week, "${widget.userEscala}-Assist", "assist");
    }
  }

  isCritical() {
    //dom 2, 9, 10, 11, 12, leve ou maior (>=2)
    //dom 6, 7 muito leve ou maior (>=1)
    return (scoreList[2] >= 2 ||
        scoreList[11] >= 1 ||
        scoreList[12] >= 1 ||
        scoreList[15] >= 2 ||
        scoreList[16] + scoreList[17] >= 2 ||
        scoreList[18] >= 2 ||
        scoreList[19] + scoreList[20] >= 2);
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
              getScore().then((_) {
                verifyScore();
                if (isCritical()) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Entre em contato com alguém!'),
                      content: const Text(
                          'Percebemos que você pode estar em um estado bastante delicado e gostaríamos de sugerir que entre em contato conosco ou com alguém próximo!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/logged-home'));
                            Navigator.of(context).pushNamed("/contacts-screen");
                          },
                          child: const Text('Ok',
                              style: TextStyle(
                                  color: Color.fromRGBO(104, 202, 138, 1))),
                        ),
                      ],
                    ),
                  );
                } else {
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
                          child: const Text('Ok',
                              style: TextStyle(
                                  color: Color.fromRGBO(104, 202, 138, 1))),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
