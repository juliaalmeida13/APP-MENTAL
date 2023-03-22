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
    verifyReadingDatabase().then((_) => getReadingGroupList());
    super.initState();
  }

  getReadingGroupList() async {
    await ReadingDatabase.instance.getReadingGroups().then((groups) {
      List<String> newGroupList = [];
      groups.forEach((element) {
        newGroupList.add(element['group'].toString());
      });
      setState(() {
        groupList = newGroupList;
      });
    });
  }

  getReadingFromRemote() async {
    await ReadingService().getReadings().then((remoteReadings) {
      remoteReadings.forEach((remoteReading) {
        ReadingDatabase.instance.add(remoteReading);
      });
      getReadingGroupList();
    });
  }

  verifyReadingDatabase() async {
    await ReadingDatabase.instance.getReadings().then((localReadings) {
      if (localReadings.isEmpty) {
        getReadingFromRemote();
      } else {
        ReadingDatabase.instance.getReadingVersion().then((localVersion) {
          ReadingService().getReadingVersion().then((remoteVersion) {
            if (localVersion < remoteVersion) {
              updateDatabase(context);
            }
          });
        });
      }
    });
  }

  updateDatabase(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Leituras recomendadas desatualizadas!'),
        content: const Text(
            'As leituras recomendadas estão desatualizadas.\nVocê deseja atualiza-las agora?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () async {
              ReadingDatabase.instance.dropAllRows().then((_) {
                getReadingFromRemote();
              });
              Navigator.pop(context, "Ok");
              shorDialogOnSuccess(context);
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }

  shorDialogOnSuccess(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Êxito!'),
        content: const Text('Leituras recomendadas atualizadas!'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context, "Ok");
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
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
