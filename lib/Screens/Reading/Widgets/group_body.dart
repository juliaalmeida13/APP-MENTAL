import 'package:app_mental/Screens/Reading/reading_screen.dart';
import 'package:app_mental/Screens/Video/video_interv_screen.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/reading_database.dart';
import '../../../model/reading.dart';

class GroupBody extends StatefulWidget {
  final String group;

  GroupBody(this.group);

  @override
  State<GroupBody> createState() => _GroupBodyState();
}

class _GroupBodyState extends State<GroupBody> {
  List<Reading> readingList = [];

  @override
  void initState() {
    getReadingDatabase();
    super.initState();
  }

  getReadingDatabase() async {
    await ReadingDatabase.instance
        .getReadingsByGroup(widget.group)
        .then((reading) {
      setState(() {
        readingList = reading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: AppColors.cinzamedio,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: readingList.length,
                  itemBuilder: (context, index) {
                    var reading = readingList.elementAt(index);
                    return IntervCard(reading: reading);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IntervCard extends StatelessWidget {
  final Reading reading;

  const IntervCard({
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
              return this.reading.type != "video"
                  ? ReadingScreen(
                      reading.name,
                      reading.text,
                      reading.image,
                      reading.id,
                    )
                  : VideoScreen(
                      reading.name, reading.text, reading.video, reading.id);
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
