import 'package:chat_app_tutorial/Screens/Reading/Widgets/img_and_text_info.dart';
import 'package:chat_app_tutorial/Screens/Reading/Widgets/intervention_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Column(
      children: [
        InterventionTitle(text:'Jardinagem'),
        SafeArea(
              child:ImgAndTextInfoCard(size:size,interventionImage: "assets/images/gardening02.jpg", interventionText: "assets/text/test.md"),
          ),
      ],
    );
  }
}

