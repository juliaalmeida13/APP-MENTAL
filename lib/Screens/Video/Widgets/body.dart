import 'package:app_mental/Screens/Video/Widgets/vid_and_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body(this.text, this.videoUrl);
  final String text;
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SafeArea(
          child: VidAndTextInfoCard(
            size: size,
            text: text,
            videoUrl: videoUrl,
          ),
        ),
      ],
    );
  }
}
