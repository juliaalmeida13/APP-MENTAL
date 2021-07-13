import 'package:chat_app_tutorial/Screens/Video/Widgets/intervention_title.dart';
import 'package:chat_app_tutorial/Screens/Video/Widgets/vid_and_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Column(
      children: [
        InterventionTitle(text:'Título'),
        SafeArea(
          child:VidAndTextInfoCard(size:size, interventionText: "assets/text/test.md"), //texto intervenção 25
        ),
      ],
    );
  }
}

