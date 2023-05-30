// import 'package:app_mental/Screens/ChatPage/ChatPage.dart';
import 'package:app_mental/Screens/ChatRoom/chatRoomsScreen.dart';
import 'package:app_mental/Screens/AudioTextDiaryPage/audio_text_diary.dart';
import 'package:app_mental/Screens/Contacts/contact_chat_screen.dart';
import 'package:app_mental/Screens/EditProfile/edit_profile_screen.dart';
import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Screens/MemoryGamePage/memory_game_screen.dart';
import 'package:app_mental/Screens/Questionarie/Charts/chart_general_screen.dart';
import 'package:app_mental/Screens/Questionarie/quests_screen.dart';
import 'package:app_mental/Screens/SleepDiary/sleep_diary.dart';
import 'package:app_mental/Screens/Tutorial/tutorial_screen.dart';
import 'package:app_mental/Screens/Questionarie/Charts/chart_week_screen.dart';
import 'package:app_mental/escalas/question_screen.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/Home/home_screen.dart';
import 'Screens/Questionarie/Charts/chart_promis_screen.dart';
import 'Screens/Questionarie/Charts/SleepScreen/chart_sleep_screen.dart';
import 'Screens/Questionarie/Charts/chart_substance_screen.dart';
import 'Screens/ResetPassword/reset_password.dart';
import 'Screens/SignIn/signin.dart';
import 'Screens/Reading/recomended_readings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  /*initializeDateFormatting('pt_BR', null).then(
    (_) =>*/
  runApp(
    MyApp(),
    //),
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [Locale('pt', 'BR')],
      routes: {
        ContactsScreen.routeName: (ctx) => ContactsScreen(),
        QuestionScreen.routeName: (ctx) => QuestionScreen(),
        "/tutorial": (ctx) => TutorialScreen(),
        "/reset-password": (ctx) => ResetPassword(),
        "/sign-in": (ctx) => SignIn(),
        "/readings": (ctx) => RecomendedReadings(),
        "/logged-home": (ctx) => HomeScreen(),
        "/sleep-diary": (ctx) => SleepPage(),
        "/chat": (ctx) => ChatRoom(),
        "/quests-screen": (ctx) => QuestsScreen(),
        "/audio-text-diary": (ctx) => AudioTextDiary(),
        "/edit-profile-screen": (ctx) => EditProfileScreen(),
        "/contacts-chat-screen": (ctx) => ContactChatScreen(),
        "/memory_game_screen": (ctx) => MemoryGameScreen(),
        "/chat-room-screen": (ctx) => ChatRoom(),
        "/chart-result-screen": (ctx) => ChartWeekScreen(),
        "/chart-general-screen": (ctx) => ChartGeneralScreen(),
        "/chart-promis-screen": (ctx) => ChartPromisScreen(),
        "/chart-substance-screen": (ctx) => ChartSubstanceScreen(),
        "/chart-sleep-screen": (ctx) => ChartSleepScreen(),
      },
      home: (userIsLoggedIn ?? false) ? HomeScreen() : SignIn(),
    );
  }
}
