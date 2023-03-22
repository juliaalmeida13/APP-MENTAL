import 'package:app_mental/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VidAndTextInfoCard extends StatelessWidget {
  const VidAndTextInfoCard({
    required this.videoUrl,
    required this.size,
    required this.text,
  });

  final Size size;
  final String videoUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -1),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VideoPlayer(size: size, videoUrl: videoUrl),
            InfoTextCard(size: size, text: text)
          ],
        ),
      ),
    );
  }
}

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({required this.size, required this.videoUrl});

  final Size size;
  final String videoUrl;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.videoUrl,
      flags: YoutubePlayerFlags(
        startAt: 0,
        controlsVisibleAtStart: true,
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.9,
      height: 200,
      margin: EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              width: widget.size.width,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: YoutubePlayer(
                controller: _youtubeController,
                aspectRatio: 16 / 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoTextCard extends StatelessWidget {
  const InfoTextCard({
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

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
          child: InfoText(markdownFile: text),
        ),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  const InfoText({
    required this.markdownFile,
  });

  final String markdownFile;

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
    Size size = MediaQuery.of(context).size;
    return Container(
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
                  data: markdownFile),
            ),
          ],
        ),
      ),
    );
  }

  MarkdownStyleSheet mrkdnTextTheme(BuildContext context) {
    return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        textScaleFactor: 1.5,
        p: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.66)));
  }
}
