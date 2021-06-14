import 'dart:ui';
import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class InfoTextAndPicture extends StatelessWidget {
  const InfoTextAndPicture({
    Key key,
    this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(children: [
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            width: size.width,

            /// Esse TextoMarkdown é um componente que eu criei q recebe o nome do arquivo q tem o markdown que vc quer renderizar
            child: InfoText(textFile: "assets/text/test.md"),
            decoration: BoxDecoration(
              color: kBackgroundYellow,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
        ),
        Positioned(
            top: 100,
            left: (size.width - 190) / 2,
            height: 160,
            width: 190,
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.35))
                ],
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover)))),
      ]),
    );
  }
}

/// VC FINGE Q ISSO N EXISTE
/// N TEM NADA AQUI PRA BAIXO
///
/// Markdown Text Widget
class InfoText extends StatelessWidget {
  const InfoText({
    Key key,
    @required this.textFile,
  }) : super(key: key);

  final String textFile;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: rootBundle.loadString(textFile),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(top: 80, left: 10, right: 10),
              child: SizedBox(
                height: 460,
                child: Column(
                  children: [
                    Expanded(
                      child: Markdown(
                          styleSheet: MrkdnTextTheme(context),
                          data: snapshot.data),
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
