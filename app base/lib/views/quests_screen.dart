import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import '../escalas/promisn1/promisn1_screen.dart';
//import './promisn2_screen.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/database.dart';

class QuestsScreen extends StatefulWidget {
  static const routeName = '/quests-screen';
  @override
  _QuestsScreenState createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  DateTime pickedDate;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  String userEmail;
  Stream questsScreenStream;

  @override
  void initState() {
    getUserInfo();
    super.initState();
    pickedDate = DateTime.now();
  }

  getUserInfo() async {
    userEmail = await HelperFunctions.getUserEmailInSharedPreference();
    databaseMethods.getQuests(userEmail).then((val) {
      setState(() {
        questsScreenStream = val;
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionários'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: questsScreenStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data.docs[index].get("questName"));
                    print(index);
                    return QuestsTile(
                        snapshot.data.docs[index].get("questName"),
                        snapshot.data.docs[index]);
                  },
                )
              : Container();
        },
      ),
    );
  }
}

class QuestsTile extends StatelessWidget {
  final String questName;
  final DocumentSnapshot snap;

  QuestsTile(this.questName, this.snap);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
              title: Text(questName),
              onTap: () {
                Navigator.of(context).pushNamed(Promisn1Screen.routeName,
                    arguments: {'title': 'PROMIS Nível 1'});
              },
            ),
            Divider(thickness: 2.0),
          ],
        ));
  }
}
