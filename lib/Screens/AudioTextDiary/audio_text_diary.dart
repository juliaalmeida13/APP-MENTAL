import 'package:app_mental/classes/audioDiaryClass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:app_mental/helper/helperfuncions.dart';
import 'package:app_mental/classes/textDatabase.dart';
import 'package:app_mental/classes/textDiaryClass.dart';
import 'package:app_mental/Screens/AudioTextDiary/AudioDiary/audio_diary.dart';
import 'package:app_mental/Screens/AudioTextDiary/TextDiary/text_diary.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/classes/audioDatabase.dart';

class AudioTextDiary extends StatefulWidget {
  @override
  State<AudioTextDiary> createState() => _AudioTextDiaryState();
}

class _AudioTextDiaryState extends State<AudioTextDiary> {
  final newDiaryTextController = TextEditingController();
  final recorder = FlutterSoundRecorder();

  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    await recorder.startRecorder(
        toFile: "${_getDateNow()}.aac", codec: Codec.aacMP4);
  }

  Future stopRecorder() async {
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    String userEmail = await getUserEmail();
    setState(() {
      AudioDatabase.instance
          .add(AudioDiaryClass(userEmail: userEmail, audioPath: filePath));
    });
    Navigator.of(context).pop();
  }

  Future<String> getUserEmail() async {
    return await HelperFunctions.getUserEmailInSharedPreference();
  }

  void _showAlertNewDiary(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: FittedBox(
                    child: Text("Insira um novo texto no seu diário:")),
                content: Stack(
                  children: <Widget>[
                    Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLines: 3,
                              controller: newDiaryTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'vazio';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text("Adicionar"),
                              onPressed: () async {
                                String userEmail = await getUserEmail();
                                if (newDiaryTextController.text != "") {
                                  setState(() {
                                    TextDatabase.instance.add(
                                      TextDiaryClass(
                                        userEmail: userEmail,
                                        createdDate: _getDateNow(),
                                        descriptionText:
                                            newDiaryTextController.text,
                                      ),
                                    );

                                    newDiaryTextController.clear();
                                  });
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Icon(recorder.isRecording
                                  ? Icons.stop
                                  : Icons.mic),
                              onPressed: () async {
                                if (recorder.isRecording) {
                                  await stopRecorder();
                                  setState(() {});
                                } else {
                                  await startRecord();
                                  setState(() {});
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
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
          bottom: new PreferredSize(
            preferredSize: new Size(300.0, 50.0),
            child: new Container(
              width: 300.0,
              child: new TabBar(
                indicatorColor: AppColors.verdeclaro,
                labelStyle: AppTextStyles.titulotab,
                labelColor: Colors.black,
                tabs: [
                  new Container(
                    height: 50.0,
                    child: new Tab(text: 'Diário em texto'),
                  ),
                  new Container(
                    height: 50.0,
                    child: new Tab(text: 'Diário em áudio'),
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

String _getDateNow() {
  var todayDate = new DateTime.now();
  var formatterDate = new DateFormat('dd-MM-yy HH-mm');
  String formattedDate = formatterDate.format(todayDate);
  return formattedDate;
}
