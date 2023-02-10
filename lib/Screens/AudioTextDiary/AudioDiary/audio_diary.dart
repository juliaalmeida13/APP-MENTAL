import 'package:app_mental/classes/audioDatabase.dart';
import 'package:app_mental/classes/audioDiaryClass.dart';
import 'package:flutter/material.dart';

class AudioDiary extends StatelessWidget {
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
                              title: Text("${audioDiary.audioPath}h"),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  //_openAlertDeleteCard(context, textDiary.id);
                                },
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
