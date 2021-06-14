import 'dart:ui';
import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/material.dart';


class InfoTitle extends StatelessWidget {
  const InfoTitle({
    Key key,
    this.title,
  }) : super(key: key);


  final String title;

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.bottomRight,
      child: Padding(padding: const EdgeInsets.only(top: kDefaultPadding),
        child: Container(
          height: 45,
          child: Text(
              title,
              style:TextStyle(color: kTextColorGray, fontSize: 35, fontWeight: FontWeight.bold)
              )
          ),
        ),

    );
  }
}
