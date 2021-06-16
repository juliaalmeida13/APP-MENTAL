import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget> [
          TitleWithCustomUnderline(text: title),
          Spacer(),
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
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(top:kDefaultPadding),
        height: 40,
        child: Padding(
              padding: const EdgeInsets.only(right: kDefaultPadding),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:"$text\n".toUpperCase(),
                  style: TextStyle(color:kTextColorGray, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
      ),
    );
  }
}
