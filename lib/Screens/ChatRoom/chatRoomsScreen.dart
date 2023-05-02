import 'package:app_mental/Screens/ChatPage/ChatPage.dart';
import 'package:app_mental/Services/channelService.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:app_mental/Shared/Widgets/MainAppBar.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:app_mental/model/channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  static const routeName = '/chat-room-screen';

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream<QuerySnapshot<Object?>>? chatRoomsStream;
  late String _email;
  List<Channel> _channels = [];

  Widget chatRoomList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return this._channels.isNotEmpty && this._channels.length > 0
            ? ListView.builder(
                itemCount: this._channels.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(this._channels[index].nameResearcher,
                      this._channels[index]);
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserEmail();
  }

  getUserEmail() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((email) {
      ChannelService().getUserChannels(email).then((channels) {
        setState(() {
          this._email = email;
          this._channels = channels;
        });
      });
    });
  }

  _goBackPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/contacts-chat-screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextColorGreen,
        title: Text("Chat"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _goBackPage(context),
        ),
      ),
      body: chatRoomList(),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final Channel channel;
  ChatRoomTile(this.userName, this.channel);

  _openChatRoom(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatPage(channel: channel)));
  }

  Widget _notification() {
    return channel.messageQuantity > 0
        ? Container(
            width: 20,
            height: 20,
            decoration: new BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: FittedBox(child: Text(channel.messageQuantity.toString())),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this._openChatRoom(context);
      },
      child: Column(
        children: [
          Container(
            color: Colors.black26,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Stack(
              children: [
                Row(
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
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _notification(),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
