import 'dart:ui';

import 'package:app_mental/Screens/Home/Widgets/reading_recs_cards.dart';
import 'package:app_mental/Screens/Home/Widgets/reading_stream.dart';
import 'package:app_mental/Screens/Home/Widgets/section_title.dart';
import 'package:app_mental/Services/database.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool existingReadings = false;
  @override
  void initState() {
    super.initState();
    getReadings().whenComplete(() {
      setState(() {});
    });
  }

  getReadings() async {
    var ds = await DatabaseMethods().readingsAreEmpty();

    setState(() {
      existingReadings = ds.docs.length != 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // It will provide total height and width of our screen
    Size size = MediaQuery.of(context).size;
    //it enables scrolling on small devices
    return SafeArea(
      child: Column(
        children: <Widget>[
          //SectionTitle(key:UniqueKey(),title: "Calendário"),
          //RowCalendar(key:UniqueKey()),
          if (existingReadings) ...[
            SectionTitle(key: UniqueKey(), title: "Leituras Recomendadas"),
            RecomendedReadingsStream()
          ],
          SectionTitle(key: UniqueKey(), title: "Outras Leituras"),
          RecomendsReadings(),
          //TitleWithMoreBttn(title: "Featured Plants", press: () {}),
          //FeaturedPlants(),
          //SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
