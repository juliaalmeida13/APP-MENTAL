import 'package:app_mental/Screens/Reading/reading_screen.dart';
import 'package:app_mental/Screens/Video/video_interv_screen.dart';
import 'package:app_mental/Services/auth.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/Services/interventions.dart';
import 'package:app_mental/classes/Intervention.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Constroi uma lista de intervencoes que foram recomendadas a partir das respostas de escalas/questionários do usuário
class RecomendedReadingsStream extends StatefulWidget {
  @override
  _RecomendedReadingsStreamState createState() =>
      _RecomendedReadingsStreamState();
}

class _RecomendedReadingsStreamState extends State<RecomendedReadingsStream> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream<QuerySnapshot<Object?>>? readingsStream;

  
  Widget readingsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: readingsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // Caso houver recomendacoes no banco, cria-se a lista
        return snapshot.hasData && snapshot.data!.docs.length > 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 140,
                    margin: EdgeInsets.only(left: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data!.docs[index].get("readingsId"));
                        var i = Interventions().getInterventionById(
                            snapshot.data!.docs[index].get("readingsId"));
                        print(i!.arquivo);
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 300,
                          child: RecomendedReadingCard(
                            intervention: i,
                            userEmail: Constants.myEmail,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfo().whenComplete(() {
      setState(() {});
    });
  }

  getUserInfo() async {
    Constants.myEmail = await HelperFunctions.getUserEmailInSharedPreference();
    Constants.myEmail = Constants.myEmail.trim();
    print(Constants.myEmail);
    databaseMethods.getRecomendedReadings().then((val) {
      setState(() {
        readingsStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return readingsList();
  }
}

class RecomendedReadingCard extends StatelessWidget {
  const RecomendedReadingCard({
    required this.userEmail,
    required this.intervention,
  });

  final String userEmail;
  final Intervention intervention;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (intervention.tipo != "video") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadingScreen(
                      intervention.nome,
                      intervention.arquivo,
                      intervention.imagem,
                      intervention.id)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoScreen(
                      intervention.nome,
                      intervention.arquivo,
                      intervention.video,
                      intervention.id)));
        }
      },
      child: Row(children: [
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(intervention.imagem),
                      ))),
              Container(
                width: 300,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kBackgroundGrey.withOpacity(0.23),
                      ),
                    ]),
                child: Text(
                  intervention.nome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
