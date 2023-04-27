import 'package:app_mental/Screens/Home/Widgets/main_card_button.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class ContactChatScreen extends StatefulWidget {
  static const routeName = '/contacts-chat-screen';

  @override
  State<ContactChatScreen> createState() => _ContactChatScreenState();
}

class _ContactChatScreenState extends State<ContactChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        shadowColor: Colors.transparent,
        title: Text("Contatos"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainCardButton("Contatos de Emergência", Icons.contact_phone,
                    "/contacts-screen", 0),
                MainCardButton("Chat", Icons.list_alt, "/chat", 0)
              ],
            ),
          ],
        ),
      ),
    );
  }
}