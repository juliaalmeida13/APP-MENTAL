import 'package:app_mental/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VidAndTextInfoCard extends StatelessWidget {
  const VidAndTextInfoCard({
    required Key key,
    required this.videoID,
    required this.size,
    required this.interventionText,
  }) : super(key: key);

  final Size size;
  final String videoID;
  final String interventionText;

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
            VideoPlayer(key: UniqueKey(), size: size, videoId: videoID),
            InfoTextCard(
                key: UniqueKey(), size: size, textFile: interventionText)
          ],
        ),
      ),
    );
  }
}

///imagem ilustrativa
///

class VideoPlayer extends StatelessWidget {
  const VideoPlayer(
      {required Key key, required this.size, required this.videoId})
      : super(key: key);

  final Size size;
  final String videoId;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width * 0.9,
        height: 200,
        margin: EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 1),
              child: Container(
                width: size.width,
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
                      controller: YoutubePlayerController(
                          initialVideoId: videoId,
                          flags: YoutubePlayerFlags(
                            startAt: 0,
                            controlsVisibleAtStart: true,
                            autoPlay: true,
                          )),
                      aspectRatio: 16 / 9,
                    )

                    ///'https://www.youtube.com/watch?v=C30hQ0ZSFoM',
                    )),
          ],
        ));
  }
}

///Texto da intervencao
class InfoTextCard extends StatelessWidget {
  const InfoTextCard({
    required Key key,
    required this.size,
    required this.textFile,
  }) : super(key: key);

  final Size size;
  final String textFile;

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
            child: InfoText(key: UniqueKey(), markdownFile: textFile)),
      ),
    );
  }
}

/// Markdown Text Widget
class InfoText extends StatelessWidget {
  const InfoText({
    required Key key,
    required this.markdownFile,
  }) : super(key: key);

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
    return FutureBuilder(
        future: rootBundle.loadString(markdownFile),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
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
                          styleSheet: MrkdnTextTheme(context),
                          data: snapshot.data!),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  /// Markdown Text Style
  MarkdownStyleSheet MrkdnTextTheme(BuildContext context) {
    return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        textScaleFactor: 1.5,
        p: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.66)));
  }
}
