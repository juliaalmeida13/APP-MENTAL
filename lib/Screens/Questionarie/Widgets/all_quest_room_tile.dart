import 'package:app_mental/Screens/Questionarie/Widgets/all_quiz_card.dart';
import 'package:flutter/material.dart';

import '../../../Services/questionnaireService.dart';
import '../../../helper/constants.dart';
import '../../../model/score.dart';

class AllQuestRoomTile extends StatefulWidget {
  final String questName;
  final String questCode;
  final String email;

  AllQuestRoomTile(this.questName, this.questCode, this.email);

  @override
  State<AllQuestRoomTile> createState() => _AllQuestRoomTileState();
}

class _AllQuestRoomTileState extends State<AllQuestRoomTile> {
  List<Score> scoreList = [];

  @override
  Widget build(BuildContext context) {
    return AllQuizCard(
      title: widget.questName,
      onTap: () {
        if (widget.questCode == QuestionnaireCode.pn1.name) {
          QuestionnaireService()
              .getScoreByWeekApp(widget.email, widget.questCode)
              .then((scores) => scoreList.addAll(scores))
              .whenComplete(
                () => Navigator.of(context).pushNamed(
                  "/chart-promis-screen",
                  arguments: {
                    'questName': widget.questName,
                    'questCode': widget.questCode,
                    'email': widget.email,
                    'scoreList': scoreList,
                  },
                ),
              );
        } else if (widget.questCode == QuestionnaireCode.assistn2.name) {
          print("oi assist");
          //chart substances
        } else if (widget.questCode ==
            QuestionnaireCode.sleepQuestionnaire.name) {
          Navigator.of(context).pushNamed("/chart-sleep-screen");
        } else {
          QuestionnaireService()
              .getScoreByWeekApp(widget.email, widget.questCode)
              .then((scores) => scoreList.addAll(scores))
              .whenComplete(
                () => Navigator.of(context).pushNamed(
                  "/chart-general-screen",
                  arguments: {
                    'questName': widget.questName,
                    'questCode': widget.questCode,
                    'email': widget.email,
                    'scoreList': scoreList,
                  },
                ),
              );
        }
      },
    );
  }
}
