import 'package:app_mental/Screens/MemoryGamePage/memory_game_body.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class MemoryGameScreen extends StatelessWidget {
  _goBackPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/logged-home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text("Jogo da Memória")),
        backgroundColor: kTextColorGreen,
        shadowColor: Color.fromRGBO(1, 1, 1, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _goBackPage(context),
        ),
      ),
      body: MemoryGameBody(),
    );
  }
}
