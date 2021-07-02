import 'dart:ui';
import 'package:chat_app_tutorial/Screens/Home/Widgets/reading_recs_cards.dart';
import 'package:chat_app_tutorial/Screens/Home/Widgets/row_calendar.dart';
import 'package:chat_app_tutorial/Screens/Home/Widgets/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          HeaderWithSearchBox(size: size),
          SectionTitle(title: "Calendário"),
          RowCalendar(),
          SectionTitle(title: "Leituras Recomendadas"),
          RecomendsReadings(),
          //TitleWithMoreBttn(title: "Featured Plants", press: () {}),
          //FeaturedPlants(),
          //SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
