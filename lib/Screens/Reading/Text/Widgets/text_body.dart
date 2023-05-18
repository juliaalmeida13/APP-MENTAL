import 'package:app_mental/Screens/Reading/Text/Widgets/text_card.dart';
import 'package:app_mental/Screens/Reading/Text/Widgets/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBody extends StatefulWidget {
  TextBody(this.text);

  final String text;

  @override
  State<TextBody> createState() => _TextBodyState();
}

class _TextBodyState extends State<TextBody> {
  List<Widget> getText() {
    var mediaQuantity = '<figure class="media">'.allMatches(widget.text).length;
    if (mediaQuantity > 0) {
      List<Widget> widgetList = [];
      String text = widget.text;
      for (int i = 0; i < mediaQuantity; i++) {
        List firstPartText = text.split('<figure class="media">');
        if (firstPartText[0].length > 0) {
          widgetList.add(TextCard(text: firstPartText[0]));
        }
        List splitMediaUrl = firstPartText[1].split('watch?v=');
        List mediaUrl = splitMediaUrl[1].split('&');
        widgetList.add(VideoPlayer(videoUrl: mediaUrl[0]));
        List textSplited2 = firstPartText[1].split('</figure>');
        if (i + 1 < mediaQuantity) {
          int textIndex = text.indexOf('</figure>');
          text = text.substring(textIndex + "</figure>".length);
        } else {
          widgetList.add(TextCard(text: textSplited2[1]));
        }
      }
      return widgetList;
    } else {
      return [TextCard(text: widget.text)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: getText(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
