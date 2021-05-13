import 'package:chat_app_tutorial/helper/constants.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/auth.dart';
import 'package:chat_app_tutorial/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../escalas/promisn1/promisn1_screen.dart';

class QuestsRoom extends StatefulWidget {
  @override
  _QuestsRoomState createState() => _QuestsRoomState();
}

class _QuestsRoomState extends State<QuestsRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream questsRoomsStream;

  Widget questsRoomList() {
    print('(((' + Constants.myEmail + ')))');
    return StreamBuilder<QuerySnapshot>(
      stream: questsRoomsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return QuestsRoomTile(
                    snapshot.data.docs[index].get("questName"),
                    snapshot.data.docs[index].get("questId"),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameInSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailInSharedPreference();
    Constants.myEmail = Constants.myEmail.trim();
    databaseMethods.getQuestsRooms(Constants.myEmail).then((val) {
      setState(() {
        questsRoomsStream = val;
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //print(Constants.myEmail);
    //print(questsRoomsStream.data.docs[1].get("questName"));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionários'),
      ),
      body: questsRoomList(),
    );
  }
}

class QuestsRoomTile extends StatelessWidget {
  final String questName;
  final String questId;
  final Map<String, dynamic> routes = {
    "pn1": Promisn1Screen.routeName,
    "pn2": Promisn1Screen.routeName,
  };
  QuestsRoomTile(
    this.questName,
    this.questId,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
                title: Text(questName),
                onTap: () {
                  Navigator.of(context).pushNamed(routes[questId],
                      arguments: {'title': questName});
                }),
            Divider(thickness: 2.0),
          ],
        ));
  }
}
