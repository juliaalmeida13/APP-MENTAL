import 'package:app_mental/Screens/Reading/TextOrVideo/text_or_video_screen.dart';
import 'package:app_mental/Services/readingService.dart';
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

  verifyUserReadingNotification() {
    widget.notificationList.forEach((element) {
      if (widget.reading.name == element.name) {
        HelperFunctions.getUserEmailInSharedPreference().then((email) {
          ReadingService()
              .readingIsRead(email, widget.reading.name, widget.group);
          widget.callback(element);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new GestureDetector(
      onTap: () {
        verifyUserReadingNotification();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              var videoUrl = "";
              if (widget.reading.video != null) {
                videoUrl = widget.reading.video!;
              }
              return TextOrVideoScreen(
                title: widget.reading.name,
                text: widget.reading.text,
                image: widget.reading.image,
                id: widget.reading.id,
                videoUrl: videoUrl,
              );
            },
          ),
        );
      },
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
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 106,
                width: 116,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                      image: AssetImage('assets/images/reading01.jpg'),
                      width: size.width,
                      fit: BoxFit.cover),
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
              top: 18,
              left: 8,
              child: _notification(),
            )
          ],
        ),
      ),
    );
  }
}
