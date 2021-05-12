import 'package:chat_app_tutorial/helper/authenticate.dart';
import 'package:chat_app_tutorial/helper/constants.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/auth.dart';
import 'package:chat_app_tutorial/services/database.dart';
import 'package:chat_app_tutorial/views/conversation_screen.dart';
import 'package:chat_app_tutorial/views/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_app_tutorial/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  QuestsRoomTile(
    this.questName,
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
                  /*Navigator.of(context).pushNamed(Promisn1Screen.routeName,
                    arguments: {'title': 'PROMIS Nível 1'});*/
                }),
            Divider(thickness: 2.0),
          ],
        ));
  }
}
