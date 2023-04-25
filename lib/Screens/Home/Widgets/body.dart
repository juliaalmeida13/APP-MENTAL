import 'package:app_mental/Services/scaleService.dart';
import 'package:flutter/material.dart';
import '../../../Services/readingService.dart';
import '../../../helper/helperfuncions.dart';
import './main_card_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int questionnaireNotificationQuantity = 0;
  int readingNotificationQuantity = 0;

  @override
  void initState() {
    super.initState();
    getQuestionnaireNotification();
  }

  getQuestionnaireNotification() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((email) {
      ScaleService()
          .getQuestionnaireIsReadCount(email)
          .then((notificationQuantity) {
        setState(() {
          questionnaireNotificationQuantity = notificationQuantity;
        });
      });
      ReadingService()
          .getReadingIsReadCount(email)
          .then((notificationQuantity) {
        setState(() {
          readingNotificationQuantity = notificationQuantity;
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
              MainCardButton("Questionários", Icons.list_alt, "/quests-screen",
                  questionnaireNotificationQuantity),
              MainCardButton("Materiais Educativos", Icons.book_online,
                  "/readings", readingNotificationQuantity)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainCardButton(
                  "Contatos", Icons.people, "/contacts-chat-screen", 0),
              MainCardButton(
                  "Diário livre", Icons.book_outlined, "/audio-text-diary", 0),
            ],
          ),
        ],
      ),
    );
  }
}
