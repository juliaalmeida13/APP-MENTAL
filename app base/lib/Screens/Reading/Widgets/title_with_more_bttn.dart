import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/material.dart';



class TitleWithMoreBttn extends StatelessWidget {
  const TitleWithMoreBttn({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final  Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Row(
        children: <Widget> [
          TitleWithCustomUnderline(text: title),
          Spacer(),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: kPrimaryGreen,
            onPressed: press,
            child: Text("More", style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding),
      child: Text(
              text,
              style:TextStyle(color: kTextColorGray, fontSize: 35, fontWeight: FontWeight.bold),
            ),
      );
  }
}
