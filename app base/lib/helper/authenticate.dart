import 'package:chat_app_tutorial/Screens/SignIn/signin.dart';
import 'package:chat_app_tutorial/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_tutorial/Screens/HomePage/home_page.dart';

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

                print(user);

                if (user == null) {
                  return SignIn();
                } else {
                  return HomePage();
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
