import 'package:app_mental/Services/scaleService.dart';
import 'package:flutter/material.dart';
import '../../../Services/readingService.dart';
import '../../../Services/sleepService.dart';
import '../../../helper/helperfuncions.dart';
import './main_card_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int questionnaireNotification = 0;
  int sleepNotification = 0;
  int readingNotification = 0;

  @override
  void initState() {
    super.initState();
    getQuestionnaireNotificationStatus();
  }

  getQuestionnaireNotificationStatus() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((email) {
      ScaleService()
          .getQuestionnaireNotificationStatus(email)
          .then((notification) {
        setState(() {
          questionnaireNotification = notification;
        });
      });
      SleepService().isSleepDiaryAnsweredToday(email).then((answered) {
        print(answered);
        setState(() {
          if (answered) {
            sleepNotification = 1;
          } else {
            sleepNotification = 0;
          }
        });
      });
      ReadingService().getReadingNotificationStatus(email).then((notification) {
        setState(() {
          readingNotification = notification;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainCardButton("Diário do sono", Icons.bed, "/sleep-diary",
                  sleepNotification),
              MainCardButton("Leitura", Icons.book_online, "/readings",
                  readingNotification)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainCardButton("Questionários", Icons.list_alt, "/quests-screen",
                  questionnaireNotification),
              MainCardButton("Contatos", Icons.people, "/contacts-screen", 0)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [MainCardButton("Tutorial", Icons.book, "/tutorial", 0)],
          ),
        ],
      ),
    );
  }
}
