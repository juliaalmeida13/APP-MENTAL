import 'package:app_mental/Screens/Reading/Widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/constants.dart';

class ReadingScreen extends StatelessWidget  {
  ReadingScreen(this.title, this.file, this.image);

  final String file;
  final String title;
  final String image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
          backgroundColor: kTextColorGreen,
          leading: BackButton(
            color: Colors.white,
            onPressed: ()=>{Navigator.pop(context)},
          ), title: Text(title)),
      resizeToAvoidBottomInset:false,
      body: Body(file, image),
    );
  }
}


