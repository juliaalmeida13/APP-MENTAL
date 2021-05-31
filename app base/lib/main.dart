import 'package:chat_app_tutorial/colors/colors.dart';
import 'package:chat_app_tutorial/colors/images.dart';
import 'package:chat_app_tutorial/helper/authenticate.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/views/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './escalas/promisn1/promisn1_screen.dart';
import './escalas/promisn2/promisn2_screen.dart';
//import './promisn2_screen.dart';
import './views/quests_screen.dart';
import './views/contacts_screen.dart';

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
        initialRoute: '/',
        //home: CategoriesScreen(),
        routes: {
          Promisn1Screen.routeName: (ctx) => Promisn1Screen(),
          //Promisn2Screen.routeName: (ctx) => Promisn2Screen(),
          //QuestsRoom.routeName: (ctx) => QuestsRoom(),
          ContactsScreen.routeName: (ctx) => ContactsScreen(),
          Promisn2Screen.routeName: (ctx) => Promisn2Screen(),
        },
        home: userIsLoggedIn != null
            ? userIsLoggedIn
                ? HomePage()
                : LandingPage()
            : Container(
                child: Center(
                  child: LandingPage(),
                ),
              ));
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;

                if (user == null) {
                  return Authenticate();
                } else {
                  return Authenticate();
                }
              }

              return Scaffold(
                backgroundColor: AppColors.green,
                body: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(AppImages.appMentalLogo),
                  )),
                ),
              );
            },
          );
        }

        return Scaffold(
          backgroundColor: AppColors.green,
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(AppImages.appMentalLogo),
            )),
          ),
        );
      },
    );
  }
}
