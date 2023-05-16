import 'package:app_mental/Screens/Reading/TextOrVideo/Widgets/image_card.dart';
import 'package:app_mental/Screens/Reading/TextOrVideo/Widgets/text_card.dart';
import 'package:app_mental/Screens/Reading/TextOrVideo/Widgets/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextOrVideoBody extends StatefulWidget {
  TextOrVideoBody(this.text, this.image, this.videoUrl);

  final String text;
  final String image;
  final String videoUrl;

  @override
  State<TextOrVideoBody> createState() => _TextOrVideoBodyState();
}

class _TextOrVideoBodyState extends State<TextOrVideoBody> {
  List<Widget> getText() {
    var timesAppear = '<figure class="media">'.allMatches(widget.text).length;
    print(timesAppear);
    if (timesAppear > 0) {
      List<Widget> widgetList = [];
      var text = widget.text;
      for (var i = 0; i < timesAppear; i++) {
        var textSplited = text.split('<figure class="media">');
        var textSplited2 = textSplited[1].split('</figure>');
        var youtubeUrl = textSplited[1].split('watch?v=');
        var youtubeUrl2 = youtubeUrl[1].split('">');
        if (textSplited[0].length > 0) {
          widgetList.add(TextCard(
              size: MediaQuery.of(context).size, text: textSplited[0]));
        }
        widgetList.add(VideoPlayer(
            size: MediaQuery.of(context).size, videoUrl: youtubeUrl2[0]));
        print(youtubeUrl2[0]);
        if (textSplited2[1].contains('<figure class="media">')) {
          text = textSplited2[1];
        } else {
          widgetList.add(TextCard(
              size: MediaQuery.of(context).size, text: textSplited2[1]));
        }
      }
      return widgetList;
    } else {
      return [
        ImageCard(size: MediaQuery.of(context).size, image: widget.image),
        TextCard(size: MediaQuery.of(context).size, text: widget.text)
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Align(
            alignment: Alignment(0, -1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: getText(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
