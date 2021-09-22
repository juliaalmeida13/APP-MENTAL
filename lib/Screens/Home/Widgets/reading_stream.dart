import 'package:app_mental/Screens/Reading/reading_screen.dart';
import 'package:app_mental/Services/auth.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    print('(((' + Constants.myEmail + ')))');
    return StreamBuilder<QuerySnapshot>(
      stream: readingsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData && snapshot.data!.docs.length > 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(left: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        print("something something");
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 100,
                          child: RecomendedReadingCard(
                            imagePath:
                                snapshot.data!.docs[index].get("imagePath"),
                            title: snapshot.data!.docs[index].get("title"),
                            readingsId:
                                snapshot.data!.docs[index].get("readingsId"),
                            isVideo: snapshot.data!.docs[index].get("isVideo"),
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
    databaseMethods.getRecomendedReadings(Constants.myEmail).then((val) {
      setState(() {
        readingsStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: readingsList());
  }
}

class RecomendedReadingCard extends StatelessWidget {
  const RecomendedReadingCard({
    required this.imagePath,
    required this.title,
    required this.readingsId,
    required this.isVideo,
    required this.userEmail,
  });

  final String imagePath, title, userEmail, readingsId;
  final bool isVideo;
  static const Map<String, dynamic> routes = {
    "sono1": "assets/text/Sleep/sleep01.md",
    "sono2": "assets/text/Sleep/sleep02.md",
    "sono3": "assets/text/Sleep/sleep03.md",
    "sono4": "assets/text/Sleep/sleep04.md",
    "reduce1": "assets/text/DamageControl/damage_control01.md",
    "reduce2": "assets/text/DamageControl/damage_control02.md",
    "reduce3": "assets/text/DamageControl/damage_control03.md",
    "reduce4": "assets/text/DamageControl/damage_control04.md",
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isVideo == false) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadingScreen(
                      title, routes[readingsId], imagePath, readingsId)));
        } else {
          /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VideoScreen()));*/
        }
      },
      child: Row(children: [
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(imagePath),
                      ))),
              Container(
                width: 100,
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
                  "$title\n",
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
