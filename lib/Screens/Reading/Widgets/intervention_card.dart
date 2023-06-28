import 'dart:convert';

import 'package:app_mental/Screens/Reading/Text/text_screen.dart';
import 'package:app_mental/Services/readingService.dart';
import 'package:app_mental/classes/reading_carousel_database.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/material.dart';

import '../../../model/reading.dart';
import '../../../model/reading_rel_user_dto.dart';

class InterventionCard extends StatefulWidget {
  final Reading reading;
  final List<ReadingRelUserDTO> notificationList;
  final String group;
  final Function callback;

  const InterventionCard(
      {required this.reading,
      required this.notificationList,
      required this.group,
      required this.callback});

  @override
  State<InterventionCard> createState() => _InterventionCardState();
}

class _InterventionCardState extends State<InterventionCard> {
  Widget _notification() {
    bool notificationStatus = false;
    widget.notificationList.forEach((element) {
      if (element.name == this.widget.reading.name) {
        notificationStatus = true;
      }
    });
    return (notificationStatus == true)
        ? Container(
            width: 20,
            height: 20,
            decoration: new BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          )
        : Container();
  }

  verifyUserReadingNotification(String readingName, String readingGroup) {
    List<ReadingRelUserDTO> listToRemoveNotification = [];
    widget.notificationList.forEach((element) {
      if (readingName == element.name) {
        listToRemoveNotification.add(element);
      }
    });
    HelperFunctions.getUserEmailInSharedPreference().then((email) {
      ReadingService().readingIsRead(email, readingName, readingGroup);
    });
    if (listToRemoveNotification.isNotEmpty) {
      widget.callback(listToRemoveNotification[0]);
    }
  }

  chooseIntervention(BuildContext context) {
    verifyUserReadingNotification(widget.reading.name, widget.reading.group);
    ReadingCarouselDatabase.instance
        .getImagesById(widget.reading.id!)
        .then((carouselImages) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return TextScreen(
              title: widget.reading.name,
              text: widget.reading.text,
              id: widget.reading.id,
              relatedReadings: widget.reading.idRelatedReading,
              verifyNotificationList: verifyUserReadingNotification,
              carouselImages: carouselImages,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new GestureDetector(
      onTap: () => chooseIntervention(context),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        height: 120,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 106,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: kBackgroundLightGreen,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 27,
                      color: Colors.black12)
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            Positioned(
              top: 15,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 106,
                width: 116,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    base64Decode(widget.reading.iconGroupImage!),
                    fit: BoxFit.cover,
                    width: size.width,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 106,

                ///our image take 116 width, so we set our total width -116
                width: size.width - 116,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(widget.reading.name,
                          style: AppTextStyles.heading),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: _notification(),
            )
          ],
        ),
      ),
    );
  }
}
