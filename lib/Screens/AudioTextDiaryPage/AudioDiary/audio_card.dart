import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

import '../../../classes/audioDatabase.dart';
import '../../../helper/date_util.dart';

class AudioCard extends StatefulWidget {
  const AudioCard(
      {Key? key,
      required this.audioPath,
      required this.audioId,
      required this.notifyParent})
      : super(key: key);

  final String audioPath;
  final int? audioId;
  final Function() notifyParent;

  @override
  State<AudioCard> createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration position = Duration.zero;

  void audioPositionChanged() {
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  void audioPlayerStateChanged() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  void audioPlayerComplete() {
    audioPlayer.onPlayerComplete.listen((complete) {
      setState(() {
        position = Duration(seconds: 0);
        isPlaying = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    audioPositionChanged();
    audioPlayerStateChanged();
    audioPlayerComplete();
  }

  void closeAlert(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteAudioCard(BuildContext context, int id) {
    setState(() {
      AudioDatabase.instance.remove(id);
    });
    widget.notifyParent();
    closeAlert(context);
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
                  onPressed: () => closeAlert(context),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text("Sim"),
                  onPressed: () => deleteAudioCard(context, id!),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  grantingPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      await Permission.storage.request();
    }
  }

  void _downloadAudio(String audioPath) {
    grantingPermission().then((_) async {
      if (await Permission.storage.status.isGranted) {
        var file = File(audioPath);
        final musicFolderPath = '/storage/emulated/0/Download';
        final musicFolder = Directory(musicFolderPath);
        if (!await musicFolder.exists()) {
          await musicFolder.create();
        }
        await file.copy(
            '$musicFolderPath/${audioPath.substring(audioPath.length - 18)}');
        _openAlertSuccessDownloadAudio(context);
      }
    });
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
              onPressed: () => closeAlert(context),
            ),
          ),
        );
      },
    );
  }

  void playAndStopPlayer() {
    if (isPlaying) {
      audioPlayer.stop();
      setState(() {
        position = Duration(seconds: 0);
        isPlaying = false;
      });
    } else {
      audioPlayer.play(DeviceFileSource("${widget.audioPath}"));
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(
          "Dia: ${getFormattedDayAndHour(widget.audioPath)}",
        ),
        subtitle: Row(
          children: [
            IconButton(
              alignment: Alignment.centerLeft,
              icon: isPlaying
                  ? Icon(Icons.stop_rounded)
                  : Icon(Icons.play_arrow_rounded),
              color: Colors.blue,
              onPressed: () => playAndStopPlayer(),
            ),
            Text(formatTime(position))
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () {
                _downloadAudio(widget.audioPath);
              },
            ),
            IconButton(
              color: Colors.red,
              icon: Icon(Icons.delete),
              onPressed: () {
                _openAlertDeleteAudioCard(context, widget.audioId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
