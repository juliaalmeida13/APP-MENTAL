import 'package:app_mental/helper/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:app_mental/classes/audioDiaryClass.dart';

import 'package:app_mental/classes/textDatabase.dart';
import 'package:app_mental/classes/textDiaryClass.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:app_mental/classes/audioDatabase.dart';

import '../../helper/util.dart';

class AlertNewDiaryEntry extends StatefulWidget {
  const AlertNewDiaryEntry({Key? key, required this.notifyParent})
      : super(key: key);
  final Function() notifyParent;

  @override
  State<AlertNewDiaryEntry> createState() => _AlertNewDiaryEntryState();
}

class _AlertNewDiaryEntryState extends State<AlertNewDiaryEntry> {
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

  void closeAlert(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future initRecorder() async {
    await Permission.storage.request();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    String url = await getCurrentUrl("${getDateNow()}.aac");
    await recorder.startRecorder(toFile: url, codec: Codec.aacMP4);
  }

  Future<String> getCurrentUrl(String url) async {
    if (Platform.isIOS) {
      String a = url.substring(url.indexOf("Documents/") + 10, url.length);
      Directory dir = await getApplicationDocumentsDirectory();
      a = "${dir.path}/$a";
      return a;
    } else {
      return url;
    }
  }

  Future stopRecorder() async {
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    String userEmail = await getUserEmail();
    setState(() {
      AudioDatabase.instance
          .add(AudioDiaryClass(userEmail: userEmail, audioPath: filePath));
    });
    closeAlert(context);
  }

  Future<String> getUserEmail() async {
    return await HelperFunctions.getUserEmailInSharedPreference();
  }

  void startAndStopRecording() async {
    if (recorder.isRecording) {
      await stopRecorder();
      setState(() {});
      widget.notifyParent();
    } else {
      await startRecord();
      setState(() {});
    }
  }

  void addNewDiaryText(BuildContext context) async {
    String userEmail = await getUserEmail();
    if (newDiaryTextController.text != "") {
      setState(() {
        TextDatabase.instance.add(
          TextDiaryClass(
            userEmail: userEmail,
            createdDate: getDateNow(),
            descriptionText: newDiaryTextController.text,
          ),
        );
        newDiaryTextController.clear();
        widget.notifyParent();
      });
    }
    closeAlert(context);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: FittedBox(child: Text("Insira um novo texto no seu diário:")),
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
                          validateEntry(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text("Adicionar"),
                        onPressed: () => addNewDiaryText(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child:
                            Icon(recorder.isRecording ? Icons.stop : Icons.mic),
                        onPressed: () => startAndStopRecording(),
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
  }
}
