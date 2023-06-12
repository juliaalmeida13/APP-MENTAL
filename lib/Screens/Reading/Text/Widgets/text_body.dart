import 'dart:convert';

import 'package:app_mental/Screens/Reading/Text/Widgets/text_card.dart';
import 'package:app_mental/Screens/Reading/Text/Widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../classes/reading_carousel_database.dart';
import '../../../../model/reading.dart';
import '../text_screen.dart';

class TextBody extends StatefulWidget {
  TextBody(this.text, this.relatedReadingList, this.verifyNotificationList,
      this.carouselImages);

  final String text;
  final List<Reading> relatedReadingList;
  final Function verifyNotificationList;
  final List<String> carouselImages;

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

  goToRelatedReading(Reading reading) {
    widget.verifyNotificationList(reading.name, reading.group);
    Navigator.pop(context);
    ReadingCarouselDatabase.instance
        .getImagesById(reading.id!)
        .then((carouselImages) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return TextScreen(
              title: reading.name,
              text: reading.text,
              id: reading.id,
              relatedReadings: reading.idRelatedReading,
              verifyNotificationList: widget.verifyNotificationList,
              carouselImages: carouselImages,
            );
          },
        ),
      );
    });
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
                widget.carouselImages.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  autoPlay: true,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3),
                              items: widget.carouselImages.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                204, 204, 204, 1)),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Image.memory(
                                        base64Decode(i),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      )
                    : Container(),
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Materiais Educativos Relacionados",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.relatedReadingList.length,
                    itemBuilder: (context, index) {
                      Reading reading = widget.relatedReadingList[index];
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 30),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: (reading.iconGroupImage != null
                                      ? Image.memory(
                                          base64Decode(reading.iconGroupImage!))
                                      : null),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 30,
                                child: Text(
                                  reading.name,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              TextButton(
                                onPressed: () => goToRelatedReading(reading),
                                child: Text(
                                  "Acessar ->",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
