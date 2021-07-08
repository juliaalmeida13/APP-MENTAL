import 'package:chat_app_tutorial/helper/authenticate.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_tutorial/escalas/promisn1/promisn1_screen.dart';
import 'package:chat_app_tutorial/escalas/promisn2/promisn2_screen.dart';
import 'package:chat_app_tutorial/escalas/pcl5/pcl5_screen.dart';
import 'package:chat_app_tutorial/escalas/pset/pset_screen.dart';
import 'package:chat_app_tutorial/Screens/Contacts/contacts_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        Promisn1Screen.routeName: (ctx) => Promisn1Screen(),
        //Promisn2Screen.routeName: (ctx) => Promisn2Screen(),
        //QuestsRoom.routeName: (ctx) => QuestsRoom(),
        ContactsScreen.routeName: (ctx) => ContactsScreen(),
        Promisn2Screen.routeName: (ctx) => Promisn2Screen(),
        Pcl5Screen.routeName: (ctx) => Pcl5Screen(),
        PsetScreen.routeName: (ctx) => PsetScreen(),
      },
      home: LandingPage(),
    );
  }
}
