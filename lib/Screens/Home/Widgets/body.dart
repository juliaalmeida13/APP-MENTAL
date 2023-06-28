import 'package:app_mental/Services/chatService.dart';
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
  int chatNotificationQuantity = 0;

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
      ChatService()
          .getUnreadMessagesQuantity(email)
          .then((notificationQuantity) {
        setState(() {
          chatNotificationQuantity = notificationQuantity;
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
              MainCardButton("Questionários", "questionarios_COR.png",
                  "/quests-screen", questionnaireNotificationQuantity),
              MainCardButton("Materiais Educativos", "leitura_COR.png",
                  "/readings", readingNotificationQuantity)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainCardButton("Contatos", "contatos_COR.png",
                  "/contacts-chat-screen", chatNotificationQuantity),
              MainCardButton(
                  "Diário livre", "diario_COR.png", "/audio-text-diary", 0),
            ],
          ),
        ],
      ),
    );
  }
}
