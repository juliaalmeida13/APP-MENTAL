import 'package:app_mental/Screens/Video/Widgets/intervention_title.dart';
import 'package:app_mental/Screens/Video/Widgets/vid_and_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Column(
      children: [
        SafeArea(
          child:VidAndTextInfoCard(key: UniqueKey(), size:size, interventionText: "assets/text/test.md", videoID: '123123123',),
        ),
      ],
    );
  }
}

