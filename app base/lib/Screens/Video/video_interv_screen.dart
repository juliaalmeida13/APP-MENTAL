import 'package:chat_app_tutorial/Screens/Video/Widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_tutorial/constants.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}


class _VideoScreenState extends State<VideoScreen> {
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

