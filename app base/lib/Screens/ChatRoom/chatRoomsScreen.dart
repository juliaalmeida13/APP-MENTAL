import 'package:chat_app_tutorial/Screens/ChatRoom/Widgets/conversation_screen.dart';
import 'package:chat_app_tutorial/Screens/ChatRoom/Widgets/search.dart';
import 'package:chat_app_tutorial/Shared/Widgets/MainAppBar.dart';
import 'package:chat_app_tutorial/helper/authenticate.dart';
import 'package:chat_app_tutorial/helper/constants.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/auth.dart';
import 'package:chat_app_tutorial/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                      snapshot.data.docs[index]
                          .get("chatRoomId")
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.docs[index].get("chatRoomId"));
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
    databaseMethods.getChatRooms(Constants.myName).then((val) {
      setState(() {
        chatRoomsStream = val;
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Authenticate(),
                ),
              );
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversarionScreen(chatRoomId)));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: mediumTextStyle(),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: mediumTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
