import 'package:flutter/material.dart';

import 'package:app_mental/Screens/AudioTextDiaryPage/AudioDiary/audio_diary.dart';
import 'package:app_mental/Screens/AudioTextDiaryPage/TextDiary/text_diary.dart';
import 'package:app_mental/Screens/AudioTextDiaryPage/alert_new_diary_entry.dart';
import 'package:app_mental/constants.dart';

class AudioTextDiary extends StatefulWidget {
  @override
  State<AudioTextDiary> createState() => _AudioTextDiaryState();
}

class _AudioTextDiaryState extends State<AudioTextDiary> {
  void _showAlertNewDiary(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertNewDiaryEntry(notifyParent: refresh);
      },
    );
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: kTextColorGreen),
          backgroundColor: Colors.white,
          title: Text("Diário", style: AppTextStyles.tituloatividades),
          actions: [
            IconButton(
              onPressed: () {
                _showAlertNewDiary(context);
              },
              icon: Icon(Icons.add_circle_outline),
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size(300.0, 50.0),
            child: Container(
              width: 300.0,
              child: TabBar(
                indicatorColor: AppColors.verdeclaro,
                labelStyle: AppTextStyles.titulotab,
                labelColor: Colors.black,
                tabs: [
                  Container(
                    height: 50.0,
                    child: Tab(text: 'Diário em texto'),
                  ),
                  Container(
                    height: 50.0,
                    child: Tab(text: 'Diário em áudio'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            TextDiary(),
            AudioDiary(),
          ],
        ),
      ),
    );
  }
}
