import 'package:app_mental/Screens/Reading/TextOrVideo/Widgets/image_card.dart';
import 'package:app_mental/Screens/Reading/TextOrVideo/Widgets/text_card.dart';
import 'package:app_mental/Screens/Reading/TextOrVideo/Widgets/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextOrVideoBody extends StatelessWidget {
  TextOrVideoBody(this.text, this.image, this.videoUrl);

  final String text;
  final String image;
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                children: [
                  videoUrl != ""
                      ? VideoPlayer(size: size, videoUrl: videoUrl)
                      : ImageCard(size: size, image: image),
                  TextCard(size: size, text: text)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
