import 'package:chat_app_tutorial/Screens/Reading/Widgets/body.dart';
import 'package:flutter/material.dart';

import 'package:chat_app_tutorial/constants.dart';

class ReadingScreen extends StatefulWidget {
  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}


class _ReadingScreenState extends State<ReadingScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: kPrimaryGreen,
          automaticallyImplyLeading: true,
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
      body: Body(),
    );
  }
}

