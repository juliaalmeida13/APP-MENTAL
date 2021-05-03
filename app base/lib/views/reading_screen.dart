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

class ReadingScreen extends StatefulWidget {
  @override
  _Reading createState() => _Reading();
}

class _Reading extends State<ReadingScreen> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // background image and bottom contents
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(25),
              height: 300.0,
              color: Colors.white,
              alignment: Alignment.topLeft,
              child:Text('Distúrbio do sono', style: TextStyle(color: Colors.black, fontSize: 25), textAlign:  TextAlign.left,),

            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top:120, right: 30, bottom: 30, left:30),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(255,230,111,1)
                ),
                  child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis scelerisque eleifend quam. Suspendisse nisi risus, congue in '
                      'tincidunt ut, convallis vel dolor. Cras iaculis feugiat consectetur. Duis ac molestie arcu. Sed non libero quis urna tincidunt '
                      'Maecenas luctus molestie libero nec placerat. Ut pulvinar suscipit ipsum in consectetur. Etiam et ex eu enim sagittis ',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.66),
                    fontSize: 17
                  ),
                ),
              ),
            )
          ],
        ),
        // Profile image
        Positioned(
          top: 90.0, // (background container size) - (circle height / 2)
          child: Container(
            height: 300.0,
            width: 300.0,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
              color: Colors.yellow.shade100,

              image: DecorationImage(
                 image: AssetImage('assets/images/undraw_sleep_analysis.png'),
                  ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],

            ),
          ),
        )
      ],
    ),
    );
  }
}

