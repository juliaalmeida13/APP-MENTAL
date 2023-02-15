import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

import 'package:app_mental/constants.dart';
import 'package:app_mental/classes/textDatabase.dart';
import 'package:app_mental/classes/textDiaryClass.dart';
import 'package:permission_handler/permission_handler.dart';

class TextDiary extends StatefulWidget {
  @override
  State<TextDiary> createState() => _TextDiaryState();
}

class _TextDiaryState extends State<TextDiary> {
  void _openAlertDeleteCard(BuildContext context, int? id) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: FittedBox(child: Text("Deseja excluir o diário?")),
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
                        TextDatabase.instance.remove(id!);
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

  Future<void> _createAndDownloadPDF() async {
    final textDiaryList = await TextDatabase.instance.getTextDiary();
    final pdf = pw.Document();
    final logoImage =
        (await rootBundle.load("assets/images/app_mental_logo.png"))
            .buffer
            .asUint8List();
    pdf.addPage(
      pw.Page(build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              pw.Image(pw.MemoryImage(logoImage),
                  width: 150, height: 150, fit: pw.BoxFit.cover),
              pw.Text("APPMental Diário"),
            ]),
            pw.ListView(
              children: textDiaryList.map((element) {
                return pw.Column(
                  children: [
                    pw.Row(
                      children: [pw.Text("Dia: ${element.createdDate}h")],
                    ),
                    pw.Row(
                      children: [
                        pw.Text(element.descriptionText),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      }),
    );
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      await Permission.storage.request();
    }
    if (await Permission.storage.status.isGranted) {
      final String downloadFolderPath =
          '/storage/emulated/0/Download/APPMentalDiario.pdf';
      final file = File(downloadFolderPath);
      await file.writeAsBytes(await pdf.save());
    }
    _openAlertSuccessCreatedPDF(context);
  }

  void _openAlertSuccessCreatedPDF(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: FittedBox(child: Text("PDF baixado com sucesso!")),
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
        child: FutureBuilder<List<TextDiaryClass>>(
            future: TextDatabase.instance.getTextDiary(),
            builder: (BuildContext context,
                AsyncSnapshot<List<TextDiaryClass>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? Center(child: Text('Nenhum texto criado ainda!'))
                  : ListView(
                      children: snapshot.data!.map((textDiary) {
                        return Center(
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              title: Text(
                                  "Dia: ${_getFormattedDayAndHourFrom(textDiary.createdDate)}"),
                              subtitle: Text(textDiary.descriptionText),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  _openAlertDeleteCard(context, textDiary.id);
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        onPressed: () {
          _createAndDownloadPDF();
        },
        backgroundColor: AppColors.darkGreen,
        child: Icon(Icons.download),
      ),
    );
  }
}

String _getFormattedDayAndHourFrom(String date) {
  return date.replaceAll("-", "/") + "h";
}
