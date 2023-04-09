import 'package:app_mental/Screens/AudioTextDiaryPage/AudioDiary/audio_card.dart';
import 'package:flutter/material.dart';

import 'package:app_mental/classes/audioDatabase.dart';
import 'package:app_mental/classes/audioDiaryClass.dart';

class AudioDiary extends StatefulWidget {
  @override
  State<AudioDiary> createState() => _AudioDiaryState();
}

class _AudioDiaryState extends State<AudioDiary> {
  refresh() {
    setState(() {});
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
                          child: AudioCard(
                              audioPath: audioDiary.audioPath,
                              audioId: audioDiary.id,
                              notifyParent: refresh),
                        );
                      }).toList(),
                    );
            }),
      ),
    );
  }
}
