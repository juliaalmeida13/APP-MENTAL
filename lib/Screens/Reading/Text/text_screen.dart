import 'dart:developer';

import 'package:app_mental/Screens/Reading/Text/Widgets/text_body.dart';
import 'package:app_mental/Services/readingService.dart';
import 'package:app_mental/classes/reading_database.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../../model/reading.dart';

class TextScreen extends StatefulWidget {
  TextScreen(
      {required this.title,
      required this.text,
      required this.id,
      required this.relatedReadings,
      required this.verifyNotificationList,
      required this.carouselImages});

  final String text;
  final String title;
  final int? id;
  final List<dynamic>? relatedReadings;
  final Function verifyNotificationList;
  final List<String> carouselImages;

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  late String userEmail;
  String ratingTitle = 'Avalie este conteúdo!';
  double initialRating = 0.0;
  String commentHint = 'Nos conte o que achou!';
  List<Reading> relatedReadingList = [];
  bool isLoading = true;

  @override
  void initState() {
    getUserEmail();
    getRelatedReadings();
    super.initState();
  }

  getUserEmail() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((email) {
      setState(() {
        userEmail = email;
      });
    });
  }

  void _showRatingDialog(context, String dialogTitle, int id) async {
    await ReadingService()
        .findReadingRating(userEmail, id)
        .then((readingRating) {
      if (readingRating.id != null) {
        ratingTitle =
            'Você já avaliou este conteúdo, deseja avaliá-lo novamente?';
        initialRating = readingRating.rating!;
        commentHint = readingRating.comment!;
      }
    });

    final _dialog = RatingDialog(
      initialRating: initialRating,
      title: Text(ratingTitle),
      message: Text(
          'Clique em uma estrela para avaliar, e adicione um comentário se quiser!'),
      submitButtonText: 'Enviar',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        ReadingService().addNewReadingRating(userEmail, id, response.rating,
            (response.comment == "") ? commentHint : response.comment);
      },
      commentHint: commentHint,
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _dialog,
    );
  }

  goBackPage(BuildContext context) {
    Navigator.pop(context);
  }

  getRelatedReadings() async {
    if (widget.relatedReadings != null) {
      await ReadingDatabase.instance
          .getListRelatedReading(widget.relatedReadings!)
          .then((readingList) {
        setState(() {
          relatedReadingList = readingList;
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextColorGreen,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => goBackPage(context),
        ),
        title: FittedBox(
          fit: BoxFit.contain,
          child: Text(widget.title),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              primary: Colors.white,
            ),
            onPressed: () {
              _showRatingDialog(context, widget.title, widget.id!);
            },
            child: Text("Avaliar"),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: isLoading
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
          : TextBody(widget.text, relatedReadingList,
              widget.verifyNotificationList, this.widget.carouselImages),
    );
  }
}
