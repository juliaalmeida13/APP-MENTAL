import 'package:app_mental/Services/database.dart';
import 'package:flutter/material.dart';
import './main_card_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool existingReadings = false;
  @override
  void initState() {
    super.initState();
    getReadings().whenComplete(() {
      setState(() {});
    });
  }

  getReadings() async {
    var ds = await DatabaseMethods().readingsAreEmpty();

    setState(() {
      existingReadings = ds.docs.length != 0;
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
              MainCardButton("Diário do sono", Icons.bed, "/sleep-diary"),
              MainCardButton("Leitura", Icons.book_online, "/readings")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainCardButton("Questionários", Icons.list_alt, "/quests-screen"),
              MainCardButton("Contatos", Icons.people, "/contacts-screen")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [MainCardButton("Tutorial", Icons.book, "/tutorial")],
          ),
        ],
      ),
    );
  }
}
