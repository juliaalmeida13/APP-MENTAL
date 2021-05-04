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

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreen createState() => _MenuScreen();
}

class _MenuScreen extends State<MenuScreen> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Pesquisar'),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 0, right: 0, bottom: 20),
              height: 150.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Text(
                          "Calendário",
                          textAlign: TextAlign.left,
                        )),
                    Container(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(104, 202, 138, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Center(
                                child: Text(
                                  "03",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(104, 202, 138, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Center(
                                child: Text(
                                  "04",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(104, 202, 138, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Center(
                                child: Text(
                                  "05",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(104, 202, 138, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Center(
                                child: Text(
                                  "06",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(104, 202, 138, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Center(
                                child: Text(
                                  "07",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ])),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                    margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Text(
                      "Leituras que talvez você possa gostar",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    )),
            Container(
                height: 400,
                child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    // Generate 100 widgets that display their index in the List.
                    children: [
                      Column(children: <Widget>[
                        Container(
                          height: 130,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        Text("Distúrbio do sono")
                      ]),
                      Column(children: <Widget>[
                        Container(
                          height: 130,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        Text("Ansiedade")
                      ]),
                      Column(children: <Widget>[
                        Container(
                          height: 130,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        Text("Depressão")
                      ]),
                      Column(children: <Widget>[
                        Container(
                          height: 130,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        Text("Ansiedade")
                      ]),
                      Column(children: <Widget>[
                        Container(
                          height: 130,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        Text("Depressão")
                      ]),
                      Column(children: <Widget>[
                        Container(
                          height: 130,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        Text("Depressão")
                      ])
                    ]))
          ])
        ]))));
  }
}
