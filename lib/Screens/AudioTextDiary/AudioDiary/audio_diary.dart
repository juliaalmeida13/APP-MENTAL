import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:app_mental/classes/audioDatabase.dart';
import 'package:app_mental/classes/audioDiaryClass.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioDiary extends StatefulWidget {
  @override
  State<AudioDiary> createState() => _AudioDiaryState();
}

class _AudioDiaryState extends State<AudioDiary> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    audioPlayer.onPlayerComplete.listen((complete) {
      setState(() {
        position = Duration(seconds: 0);
        isPlaying = false;
      });
    });
  }

  void _openAlertDeleteAudioCard(BuildContext context, int? id) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: FittedBox(child: Text("Deseja excluir o áudio?")),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Sim"),
                    onPressed: () {
                      setState(() {
                        AudioDatabase.instance.remove(id!);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _downloadAudio(String audioPath) async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      await Permission.storage.request();
    }
    if (await Permission.storage.status.isGranted) {
      var file = File(audioPath);
      final musicFolderPath = '/storage/emulated/0/Download';
      final musicFolder = Directory(musicFolderPath);
      if (!await musicFolder.exists()) {
        await musicFolder.create();
      }
      await file.copy(
          '$musicFolderPath/${audioPath.substring(audioPath.length - 18)}');
    }
    _openAlertSuccessDownloadAudio(context);
  }

  void _openAlertSuccessDownloadAudio(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: FittedBox(child: Text("Áudio baixado com sucesso!")),
            content: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<AudioDiaryClass>>(
            future: AudioDatabase.instance.getAudioDiary(),
            builder: (BuildContext context,
                AsyncSnapshot<List<AudioDiaryClass>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? Center(child: Text('Nenhum audio criado ainda!'))
                  : ListView(
                      children: snapshot.data!.map((audioDiary) {
                        return Center(
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              title: Text(
                                "Dia: ${_getFormattedDayAndHour(audioDiary.audioPath)}",
                              ),
                              subtitle: Row(
                                children: [
                                  IconButton(
                                    alignment: Alignment.centerLeft,
                                    icon: isPlaying
                                        ? Icon(Icons.stop_rounded)
                                        : Icon(Icons.play_arrow_rounded),
                                    color: Colors.blue,
                                    onPressed: () {
                                      if (isPlaying) {
                                        audioPlayer.stop();
                                        setState(() {
                                          position = Duration(seconds: 0);
                                          isPlaying = false;
                                        });
                                      } else {
                                        audioPlayer.play(DeviceFileSource(
                                            "${audioDiary.audioPath}"));
                                        setState(() {
                                          isPlaying = true;
                                        });
                                      }
                                    },
                                  ),
                                  Text(_formatTime(position))
                                ],
                              ),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.download),
                                    onPressed: () {
                                      _downloadAudio(audioDiary.audioPath);
                                    },
                                  ),
                                  IconButton(
                                    color: Colors.red,
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      _openAlertDeleteAudioCard(
                                          context, audioDiary.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
            }),
      ),
    );
  }
}

String _getFormattedDayAndHour(String path) {
  String string = path.substring(path.length - 18);
  String str = string.substring(0, string.length - 4);
  String string1 = str.replaceAll("-", "/");
  return string1.substring(0, 11) + ":" + string1.substring(12) + "h";
}

String _formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
}
