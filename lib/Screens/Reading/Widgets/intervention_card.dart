import 'package:app_mental/Screens/Reading/TextOrVideo/text_or_video_screen.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

import '../../../model/reading.dart';

class InterventionCard extends StatelessWidget {
  final Reading reading;

  const InterventionCard({
    required this.reading,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              var videoUrl = "";
              print("reading.video ${reading.video}");
              if (reading.video != null) {
                videoUrl = reading.video!;
              }
              return TextOrVideoScreen(
                title: reading.name,
                text: reading.text,
                image: reading.image,
                id: reading.id,
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
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(reading.name, style: AppTextStyles.heading),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
