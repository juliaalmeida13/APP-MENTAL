import 'package:app_mental/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_video/flutter_html_video.dart';
import 'package:flutter_html_iframe/flutter_html_iframe.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    print(text);
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
            color: Colors.amber,
            margin: EdgeInsets.only(bottom: kDefaultPadding),
            child: SizedBox(
              height: size.height * 0.53,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Html(
                      data: text,
                      /*customRenders: {
                        iframeMatcher(): iframeRender(),
                        videoMatcher(): videoRender(),
                      },*/
                      onLinkTap: (url, context, attributes, element) =>
                          launch(url!),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
