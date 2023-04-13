import 'package:app_mental/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

  MarkdownStyleSheet mrkdnTextTheme(BuildContext context) {
    return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        textScaleFactor: 1.5,
        p: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.66)));
  }

  void onTapLink(String text, String? href, String title, context) {
    if (text.startsWith("página") && href != null) {
      Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
      Navigator.of(context).pushNamed(href);
    } else {
      launch(href!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1),
      child: Container(
        width: size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          shape: BoxShape.rectangle,
        ),
        alignment: Alignment(-1, -1),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            margin: EdgeInsets.only(bottom: kDefaultPadding),
            child: SizedBox(
              height: size.height * 0.53,
              child: Column(
                children: [
                  Expanded(
                    child: Markdown(
                        onTapLink: (text, href, title) =>
                            onTapLink(text, href, title, context),
                        styleSheet: mrkdnTextTheme(context),
                        data: text),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
