import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/material.dart';


class InterventionTitle extends StatelessWidget {
  const InterventionTitle({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-1,0),
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding, bottom: kDefaultPadding/2, left: kDefaultPadding/4),
        child: Text(
          text,
          style:TextStyle(fontFamily: "Inter", color: AppColors.black,
              fontSize: 40,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}