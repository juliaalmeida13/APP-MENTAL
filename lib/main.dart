import 'package:app_mental/Screens/AudioTextDiaryPage/audio_text_diary.dart';
import 'package:app_mental/Screens/EditProfile/edit_profile_screen.dart';
import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Screens/Questionarie/quests_screen.dart';
import 'package:app_mental/Screens/SleepDiary/sleep_diary.dart';
import 'package:app_mental/Screens/Tutorial/tutorial_screen.dart';
import 'package:app_mental/escalas/question_screen.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/Home/home_screen.dart';
import 'Screens/ResetPassword/reset_password.dart';
import 'Screens/SignIn/signin.dart';
import 'Screens/UsersPage/UsersPage.dart';
import 'Screens/Reading/recomended_readings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  initializeDateFormatting('pt_BR', null).then(
    (_) => runApp(
      MyApp(),
    ),
  );
  await dotenv.load(fileName: "lib/.env");
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? userIsLoggedIn;

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
        ContactsScreen.routeName: (ctx) => ContactsScreen(),
        QuestionScreen.routeName: (ctx) => QuestionScreen(),
        "/tutorial": (ctx) => TutorialScreen(),
        "/reset-password": (ctx) => ResetPassword(),
        "/sign-in": (ctx) => SignIn(),
        "/readings": (ctx) => RecomendedReadings(),
        "/logged-home": (ctx) => HomeScreen(),
        "/sleep-diary": (ctx) => SleepPage(),
        "/users": (ctx) => UsersPage(),
        "/quests-screen": (ctx) => QuestsScreen(),
        "/audio-text-diary": (ctx) => AudioTextDiary(),
        "/edit-profile-screen": (ctx) => EditProfileScreen(),
      },
      home: (userIsLoggedIn ?? false) ? HomeScreen() : SignIn(),
    );
  }
}
