import 'dart:ui';

import 'package:app_mental/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // It will provide total height and width of our screen
    Size size = MediaQuery.of(context).size;
    //it enables scrolling on small devices
    return SafeArea(
      child: Column(
        children: <Widget>[
          StreamBuilder<DocumentSnapshot>(
              stream: DatabaseMethods().getDataQuestSonoFromAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                return new Text(userDocument!["name"]);
              }),
        ],
      ),
    );
  }
}
