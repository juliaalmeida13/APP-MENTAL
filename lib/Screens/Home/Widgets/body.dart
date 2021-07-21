import 'dart:ui';
import 'package:app_mental/Screens/Home/Widgets/reading_recs_cards.dart';
import 'package:app_mental/Screens/Home/Widgets/reading_stream.dart';
import 'package:app_mental/Screens/Home/Widgets/row_calendar.dart';
import 'package:app_mental/Screens/Home/Widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/main.dart';

import 'header_with_searchbox.dart';

class Body extends StatelessWidget {
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
          if ( //checkExistingReading()
          1 > 0)
            SectionTitle(key: UniqueKey(), title: "Leituras Recomendadas"),
          RecomendedReadingsStream(),
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
