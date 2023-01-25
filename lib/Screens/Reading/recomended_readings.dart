import 'package:flutter/material.dart';
import 'package:app_mental/Screens/Home/Widgets/reading_recs_cards.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';

import '../../constants.dart';

class RecomendedReadings extends StatelessWidget {
  const RecomendedReadings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Leituras recomendadas"),
          backgroundColor: kTextColorGreen,
          shadowColor: Color.fromRGBO(1, 1, 1, 0),
        ),
        drawer: AppDrawer(key: Key("drawer")),
        body: SafeArea(
            child: Column(
          children: [RecomendsReadings()],
        )));
  }
}
