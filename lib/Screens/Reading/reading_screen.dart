import 'package:app_mental/Screens/Reading/Widgets/body.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReadingScreen extends StatelessWidget {
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
  final DatabaseMethods databaseMethods = new DatabaseMethods();

  void _showRatingDialog(context, String dialogTitle, String id) async {
    String formattedDate = DateFormat.yMEd().add_jms().format(DateTime.now());
    bool existingRating = false;
    var ds = await DatabaseMethods().ratingsAreEmpty(id);
    String ratingTitle = 'Avalie este conteúdo!';

    existingRating = ds.docs.length != 0;
    if (existingRating) {
      ratingTitle =
          'Você já avaliou este conteúdo, deseja avaliá-lo novamente?';
    }

    final _dialog = RatingDialog(
      // your app's name?
      title: ratingTitle,
      // encourage your user to leave a high rating?
      message:
          'Clique em uma estrela para avaliar, e adicione um comentário se quiser!',
      submitButton: 'Enviar',
      onCancelled: () => print('cancelled'),

      onSubmitted: (response) {
        print(
            'rating: ${response.rating}, comment: ${response.comment}, id: $id, email: ${FirebaseAuth.instance.currentUser!.email}, now: $formattedDate');
        Map<String, dynamic> ratingMap = {
          "readingsId": id,
          "rating": response.rating,
          "comment": response.comment,
          "date": formattedDate,
        };
        databaseMethods.rateReading(
            id, ratingMap, FirebaseAuth.instance.currentUser!.uid);
      },
      commentHint: 'Nos conte o que achou!',
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
        title: Text(title),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              primary: Colors.white,
            ),
            onPressed: () {
              _showRatingDialog(context, title, id);
            },
            child: Text("Avaliar"),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Body(file, image),
    );
  }
}
