import 'dart:ui';

import 'package:app_mental/Screens/Home/Widgets/reading_recs_cards.dart';
import 'package:app_mental/Screens/Home/Widgets/reading_stream.dart';
import 'package:app_mental/Screens/Home/Widgets/section_title.dart';
import 'package:app_mental/Services/database.dart';
import 'package:flutter/material.dart';

import 'header_with_searchbox.dart';

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
    DatabaseMethods().readingsIsEmpty().then((bool empty) {
      setState(() {
        existingReadings = !empty;
      });
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
          HeaderWithSearchBox(key: UniqueKey(), size: size),
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
