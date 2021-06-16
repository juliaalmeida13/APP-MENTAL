import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:chat_app_tutorial/Screens/Reading/Widgets/info_and_text_picture.dart';
import 'package:chat_app_tutorial/Screens/Reading/Widgets/info_title.dart';
import 'package:chat_app_tutorial/Screens/Reading/Widgets/title_with_more_bttn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Column(
      children: [
          Column(
            children: <Widget>[
               TitleWithMoreBttn(title:"Jardinagem", press: (){}),
              InfoTitle(title: "Jardinagem"),
              InfoTextAndPicture(image: "assets/images/gardening02.jpg"),
            ],
          ),
        ],
    );
  }
}
