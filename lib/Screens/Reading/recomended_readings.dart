import 'package:app_mental/Services/readingService.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/Screens/Reading/group_reading_cards.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';

import '../../classes/reading_database.dart';
import '../../constants.dart';

class RecomendedReadings extends StatefulWidget {
  const RecomendedReadings({Key? key}) : super(key: key);

  @override
  State<RecomendedReadings> createState() => _RecomendedReadingsState();
}

class _RecomendedReadingsState extends State<RecomendedReadings> {
  List<String> groupList = [];

  @override
  void initState() {
    getReadingDatabase().then((_) {
      getReadingGroupList();
    });
    super.initState();
  }

  getReadingGroupList() async {
    await ReadingDatabase.instance.getReadingGroups().then((groups) {
      groups.forEach((element) {
        groupList.add(element['group'].toString());
      });
      setState(() {});
    });
  }

  getReadingDatabase() async {
    await ReadingDatabase.instance.getReadings().then((localReadings) {
      if (localReadings.isEmpty) {
        ReadingService().getReadings().then((remoteReadings) {
          remoteReadings.forEach((remoteReading) {
            ReadingDatabase.instance.add(remoteReading);
          });
        });
      } else {
        ReadingDatabase.instance.getReadingVersion().then((localVersion) {
          ReadingService().getReadingVersion().then((remoteVersion) {
            if (localVersion < remoteVersion) {
              //get the diferences
              /*ReadingService().getReadings().then((readings) {
                setState(() {
                  readingList = readings;
                });
              });*/
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Leituras recomendadas"),
          backgroundColor: kTextColorGreen,
          shadowColor: Color.fromRGBO(1, 1, 1, 0),
        ),
        body: SafeArea(
            child: Column(
          children: [GroupReadingCards(groupList: groupList)],
        )));
  }
}
