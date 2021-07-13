import 'package:app_mental/Screens/Video/Widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/constants.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}


class _VideoScreenState extends State<VideoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kTextColorGreen,
          leading: BackButton(
          color: Colors.white,
        onPressed: ()=>{Navigator.pop(context)},
      ), title: Text("Titulo")),
      resizeToAvoidBottomInset:false,
      key: scaffoldKey,

      body: Body(),
    );
  }
}

