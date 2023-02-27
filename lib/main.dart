import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Screens/Questionarie/quests_screen.dart';
import 'package:app_mental/Screens/SleepDiary/sleep_diary.dart';
import 'package:app_mental/Screens/Tutorial/tutorial_screen.dart';
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
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Screens/Home/home_screen.dart';
import 'Screens/ResetPassword/reset_password.dart';
import 'Screens/SignIn/signin.dart';
import 'Screens/UsersPage/UsersPage.dart';
import 'Services/interventions.dart';
import 'Screens/Reading/recomended_readings.dart';

void main() async {
  initializeDateFormatting('pt_BR', null).then((_) => runApp(MyApp()));
  await dotenv.load(fileName: "lib/.env");
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? userIsLoggedIn;

  @override
  void initState() {
    Interventions().loadGroups();
    Interventions().loadInterventions();
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'App Mental',
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
        QuestSD1Screen.routeName: (ctx) => QuestSD1Screen(),
        QuestSD2Screen.routeName: (ctx) => QuestSD2Screen(),
        MdqScreen.routeName: (ctx) => MdqScreen(),
        PromisAnsiScreen.routeName: (ctx) => PromisAnsiScreen(),
        Phq15Screen.routeName: (ctx) => Phq15Screen(),
        PsqiScreen.routeName: (ctx) => PsqiScreen(),
        AssistScreen.routeName: (ctx) => AssistScreen(),
        Assistn2Screen.routeName: (ctx) => Assistn2Screen(),
        "/tutorial": (ctx) => TutorialScreen(),
        "/reset-password": (ctx) => ResetPassword(),
        "/sign-in": (ctx) => SignIn(),
        "/readings": (ctx) => RecomendedReadings(),
        "/logged-home": (ctx) => HomeScreen(),
        "/sleep-diary": (ctx) => SleepPage(),
        "/users": (ctx) => UsersPage(),
        "/quests-screen": (ctx) => QuestsScreen(),
      },
      home: (userIsLoggedIn ?? false) ? HomeScreen() : SignIn(),
    );
  }
}
