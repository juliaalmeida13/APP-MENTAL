import 'package:app_mental/Screens/Video/Widgets/body.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen(this.title, this.file, this.videoId);

  final String file;
  final String title;
  final String videoId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kTextColorGreen,
          leading: BackButton(
            color: Colors.white,
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text(title)),
      resizeToAvoidBottomInset: false,
      key: UniqueKey(),
      body: Body(file, videoId),
    );
  }
}
