import 'package:app_mental/Services/readingService.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/Screens/Reading/group_reading_cards.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';

import '../../classes/reading_carousel_database.dart';
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
  List<String> readingIconList = [];
  List<ReadingRelUserDTO> notificationList = [];
  List<int> groupSizeList = [];
  bool isLoading = true;

  @override
  void initState() {
    verifyReadingDatabase();
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
      List<String> newIconList = [];
      for (int i = 0; i < groups.length; i++) {
        newGroupList.add(groups[i]['group']);
        newIconList.add(groups[i]['iconGroupImage'] == null
            ? ""
            : groups[i]['iconGroupImage']);
      }
      setState(() {
        readingGroupList = newGroupList;
        readingIconList = newIconList;
      });
      getReadingGroupSize();
    });
  }

  getReadingGroupSize() async {
    for (int i = 0; i < readingGroupList.length; i++) {
      await ReadingDatabase.instance
          .getReadingGroupSize(readingGroupList[i])
          .then((value) {
        setState(() {
          groupSizeList.add(value);
        });
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  getReadingFromRemote() async {
    await ReadingService().getReadings().then((remoteReadings) {
      remoteReadings.forEach((remoteReading) {
        ReadingDatabase.instance.add(remoteReading);
      });
      getReadingGroupList();
    });
    await ReadingService()
        .getReadingsImageCarousel()
        .then((remoteReadingsImage) {
      remoteReadingsImage.forEach((remoteReading) {
        ReadingCarouselDatabase.instance.add(remoteReading);
      });
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
            } else {
              getReadingGroupList();
            }
          });
        });
      }
    });
  }

  closeAlertDialog(BuildContext context) {
    getReadingGroupList();
    Navigator.pop(context);
  }

  updateReadings(BuildContext context) async {
    ReadingCarouselDatabase.instance.dropAllRows();
    ReadingDatabase.instance.dropAllRows().then((_) {
      getReadingFromRemote();
    });
    Navigator.pop(context);
    showDialogOnSuccess(context);
  }

  updateDatabase(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Materiais educativos desatualizados!'),
        content: const Text(
            'Os materiais educativos estão desatualizados.\nVocê deseja atualiza-las agora?'),
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

  showDialogOnSuccess(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Êxito!'),
        content: const Text('Materiais educativos atualizados!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => closeAlertDialog(context),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  goBackPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/logged-home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Materiais educativos"),
        backgroundColor: kTextColorGreen,
        shadowColor: Color.fromRGBO(1, 1, 1, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => goBackPage(context),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : Column(
                children: [
                  GroupReadingCardsList(
                    readingGroupList: readingGroupList,
                    notificationList: notificationList,
                    groupSizeList: groupSizeList,
                    readingIconList: readingIconList,
                  )
                ],
              ),
      ),
    );
  }
}
