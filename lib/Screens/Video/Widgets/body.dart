import 'package:app_mental/Screens/Video/Widgets/vid_and_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Body extends StatelessWidget {
  Body(this.file, this.videoId);
  final String file;
  final String videoId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SafeArea(
          child: VidAndTextInfoCard(
            key: UniqueKey(),
            size: size,
            interventionText: file,
            videoID: videoId,
          ),
        ),
      ],
    );
  }
}
