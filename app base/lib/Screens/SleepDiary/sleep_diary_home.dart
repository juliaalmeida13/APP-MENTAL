import 'package:chat_app_tutorial/Screens/SleepDiary/diario_sono.dart';
import 'package:flutter/material.dart';

class DiarySleepHome extends StatefulWidget {
  @override
  _DiarySleepHomeState createState() => _DiarySleepHomeState();
}

class _DiarySleepHomeState extends State<DiarySleepHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DiarioSono()));
        },
        child: Text(
            'Olá\nBem vindo ao questionário do sono\nSó clicar para começar ;)'),
      ),
    );
  }
}
