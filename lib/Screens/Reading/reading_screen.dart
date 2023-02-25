import 'package:app_mental/Screens/Reading/Widgets/body.dart';
import 'package:app_mental/Services/userService.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReadingScreen extends StatefulWidget {
  ReadingScreen(
    this.title,
    this.file,
    this.image,
    this.id,
  );

  final String file;
  final String title;
  final String image;
  final String id;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
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

  // Cria um dialogo para a avaliacao de uma intervencaos
  void _showRatingDialog(context, String dialogTitle, String id) async {
    await UserService().findReadingRating(userEmail, id).then((readingRating) {
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
        UserService().addNewReadingRating(userEmail, id, response.rating,
            (response.comment == "") ? commentHint : response.comment);
      },
      commentHint: commentHint,
    );

    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        backgroundColor: kTextColorGreen,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => {Navigator.pop(context)},
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
              _showRatingDialog(context, widget.title, widget.id);
            },
            child: Text("Avaliar"),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Body(widget.file, widget.image),
    );
  }
}
