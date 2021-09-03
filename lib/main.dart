import 'package:app_mental/Screens/ChatRoom/chatRoomsScreen.dart';
import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Screens/HomePage/home_page.dart';
import 'package:app_mental/Screens/Questionarie/quests_screen.dart';
import 'package:app_mental/Screens/SignIn/signin.dart';
import 'package:app_mental/Screens/SleepDiary/sleep_diary.dart';
import 'package:app_mental/escalas/assist/assist_screen.dart';
import 'package:app_mental/escalas/assistn2/assistn2_screen.dart';
import 'package:app_mental/escalas/mdq/mdq_screen.dart';
import 'package:app_mental/escalas/pcl5/pcl5_screen.dart';
import 'package:app_mental/escalas/phq15/phq15_screen.dart';
import 'package:app_mental/escalas/promisAnsiedade/promisAnsi_screen.dart';
import 'package:app_mental/escalas/promisn1/promisn1_screen.dart';
import 'package:app_mental/escalas/promisn2/promisn2_screen.dart';
import 'package:app_mental/escalas/pset/pset_screen.dart';
import 'package:app_mental/escalas/psqi/psqi_screen.dart';
import 'package:app_mental/escalas/questSD1/questSD1_screen.dart';
import 'package:app_mental/escalas/questSD2/questSD2_screen.dart';
import 'package:app_mental/helper/authenticate.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'escalas/quesi/quesi_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool userIsLoggedIn;

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
        ContactsScreen.routeName: (ctx) => ContactsScreen(),
        Promisn2Screen.routeName: (ctx) => Promisn2Screen(),
        Pcl5Screen.routeName: (ctx) => Pcl5Screen(),
        PsetScreen.routeName: (ctx) => PsetScreen(),
        QuesiScreen.routeName: (ctx) => QuesiScreen(),
        QuestSD1Screen.routeName: (ctx) => QuestSD1Screen(),
        QuestSD2Screen.routeName: (ctx) => QuestSD2Screen(),
        MdqScreen.routeName: (ctx) => MdqScreen(),
        PromisAnsiScreen.routeName: (ctx) => PromisAnsiScreen(),
        Phq15Screen.routeName: (ctx) => Phq15Screen(),
        PsqiScreen.routeName: (ctx) => PsqiScreen(),
        AssistScreen.routeName: (ctx) => AssistScreen(),
        Assistn2Screen.routeName: (ctx) => Assistn2Screen(),
        "/sign-in": (ctx) => SignIn(),
        "/logged-home": (ctx) => HomePage(),
        "/sleep-diary": (ctx) => SleepPage(),
        "/chat": (ctx) => ChatRoom(),
        "/quests-screen": (ctx) => QuestsScreen(),
        "/contacts-screen": (ctx) => ContactsScreen(),
      },
      home: LandingPage(),
    );
  }
}
