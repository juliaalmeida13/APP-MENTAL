import 'package:app_mental/Screens/Video/Widgets/body.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../Services/readingService.dart';
import '../../helper/helperfuncions.dart';

class VideoScreen extends StatefulWidget {
  final int? id;
  final String text;
  final String title;
  final String? videoUrl;

  VideoScreen(this.title, this.text, this.videoUrl, this.id);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late String userEmail;
  String ratingTitle = 'Avalie este conteúdo!';
  double initialRating = 0.0;
  String commentHint = 'Nos conte o que achou!';

  @override
  void initState() {
    getUserEmail();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kTextColorGreen,
          leading: BackButton(
            color: Colors.white,
            onPressed: () => {Navigator.pop(context)},
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
          title: Text(widget.title)),
      resizeToAvoidBottomInset: false,
      body: Body(widget.text, widget.videoUrl!),
    );
  }
}
