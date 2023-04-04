import 'package:app_mental/Services/readingService.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/Screens/Reading/group_reading_cards.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';

import '../../classes/reading_database.dart';
import '../../constants.dart';
import '../../model/reading_rel_user_dto.dart';

class RecomendedReadings extends StatefulWidget {
  const RecomendedReadings({Key? key}) : super(key: key);

  @override
  State<RecomendedReadings> createState() => _RecomendedReadingsState();
}

class _RecomendedReadingsState extends State<RecomendedReadings> {
  List<String> readingGroupList = [];
  List<ReadingRelUserDTO> notificationList = [];

  @override
  void initState() {
    verifyReadingDatabase().then((_) => getReadingGroupList());
    getReadingNotificationList();
    super.initState();
  }

  getReadingNotificationList() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((userEmail) {
      ReadingService()
          .getReadingNotificationList(userEmail)
          .then((notificationRemoteList) {
        setState(() {
          notificationList = notificationRemoteList;
        });
      });
    });
  }

  getReadingGroupList() async {
    await ReadingDatabase.instance.getReadingGroups().then((groups) {
      List<String> newGroupList = [];
      groups.forEach((element) {
        newGroupList.add(element['group'].toString());
      });
      setState(() {
        readingGroupList = newGroupList;
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

  closeAlertDialog(BuildContext context) {
    Navigator.pop(context);
  }

  updateReadings(BuildContext context) async {
    ReadingDatabase.instance.dropAllRows().then((_) {
      getReadingFromRemote();
    });
    closeAlertDialog(context);
    shorDialogOnSuccess(context);
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
            onPressed: () => closeAlertDialog(context),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () => updateReadings(context),
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
            onPressed: () => closeAlertDialog(context),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
            Navigator.of(context).pushNamed("/logged-home");
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GroupReadingCardsList(
                readingGroupList: readingGroupList,
                notificationList: notificationList)
          ],
        ),
      ),
    );
  }
}
