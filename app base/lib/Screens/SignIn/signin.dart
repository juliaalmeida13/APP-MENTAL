import 'package:chat_app_tutorial/Screens/ChatRoom/chatRoomsScreen.dart';
import 'package:chat_app_tutorial/Screens/Home/home_screen.dart';
import 'package:chat_app_tutorial/Screens/HomePage/home_page.dart';
import 'package:chat_app_tutorial/Screens/SignUp/signup.dart';
import 'package:chat_app_tutorial/animation/FadeAnimation.dart';
import 'package:chat_app_tutorial/constants.dart';
import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/auth.dart';
import 'package:chat_app_tutorial/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //final Function toggle;

  //SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEdittingController =
      new TextEditingController();
  TextEditingController passwordTextEdittingController =
      new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailInSharedPreference(
          emailTextEdittingController.text);

      databaseMethods
          .getUserByEmail(emailTextEdittingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameInSharedPreference(
            snapshotUserInfo.docs[0].get("name"));
        print("${snapshotUserInfo.docs[0].get("name")}");
      });
      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(emailTextEdittingController.text,
              passwordTextEdittingController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.background),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.7,
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(104, 202, 138, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  FadeAnimation(
                                      1.7,
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[100]))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                          validator: (val) {
                                            return RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(val)
                                                ? null
                                                : "Por favor verifique seu email";
                                          },
                                          controller:
                                              emailTextEdittingController,
                                        ),
                                      )),
                                  FadeAnimation(
                                      1.8,
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Senha",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                          obscureText: true,
                                          validator: (val) {
                                            return val.length > 6
                                                ? null
                                                : "Por favor verifique sua senha";
                                          },
                                          controller:
                                              passwordTextEdittingController,
                                        ),
                                      ))
                                ],
                              ),
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        1.8,
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                AppColors.green,
                                AppColors.green06,
                              ])),
                          child: TextButton(
                            onPressed: () {
                              signIn();
                            },
                            child: Center(
                              child: Text("Entrar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        )),
                    /*SizedBox(height: 40,),
                    FadeAnimation(1.9,Text(
                      "Esqueceu a Senha?",
                      style: TextStyle(
                      color: Color.fromRGBO(104, 202, 138, 1),
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                    ),*/
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      2,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Container(
                          //padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Criar conta",
                            style: TextStyle(
                              color: AppColors.green,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
