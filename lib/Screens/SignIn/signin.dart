import 'package:app_mental/Screens/ResetPassword/reset_password.dart';
import 'package:app_mental/Screens/SignUp/signup.dart';
import 'package:app_mental/Services/userService.dart';
import 'package:app_mental/animation/FadeAnimation.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEdittingController =
      new TextEditingController();
  TextEditingController passwordTextEdittingController =
      new TextEditingController();

  bool isRememberPassword = false;
  List<String> userAndPasswordStored = [];

  @override
  void initState() {
    setEmailAndPassword();
    super.initState();
  }

  setEmailAndPassword() async {
    userAndPasswordStored =
        await HelperFunctions.getUserRememberMeInSharedPreference();
    if (userAndPasswordStored.isNotEmpty) {
      setState(() {
        emailTextEdittingController.text = userAndPasswordStored[0];
        passwordTextEdittingController.text = userAndPasswordStored[1];
        isRememberPassword = true;
      });
    }
  }

  saveUserInSharedPreferences(user) {
    HelperFunctions.saveUserInfoToSharedPrefs(user);
    if (isRememberPassword) {
      HelperFunctions.saveUserInfoToSharedPrefsRememberMe(
          emailTextEdittingController.text,
          passwordTextEdittingController.text);
    } else {
      HelperFunctions.removeRememberMeInSharedPreference();
    }
  }

  signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final snackBar = SnackBar(
        content: new Row(
      children: <Widget>[
        new CircularProgressIndicator(),
        new Text("    Entrando...")
      ],
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    UserService()
        .signIn(emailTextEdittingController.text,
            passwordTextEdittingController.text, fcmToken!) //""!)
        .then((user) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      saveUserInSharedPreferences(user);
      Navigator.pushNamedAndRemoveUntil(
          context, "/logged-home", (Route<dynamic> route) => false);
    }).catchError((error) {
      final snackBar = SnackBar(
          content:
              Text(error.toString(), style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  changeIsRememberValue(newValue) {
    setState(() {
      isRememberPassword = newValue!;
    });
  }

  changePasswordInput() {
    if (userAndPasswordStored.isNotEmpty &&
        passwordTextEdittingController.text.isNotEmpty) {
      setState(() {
        passwordTextEdittingController.text = "";
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.background),
                        fit: BoxFit.fitWidth)),
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
                                                    color: Colors.grey[100]!))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                          validator: (val) {
                                            return RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(val!)
                                                ? null
                                                : "Por favor verifique seu email";
                                          },
                                          controller:
                                              emailTextEdittingController,
                                          onChanged: (_) =>
                                              changePasswordInput(),
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
                                            return val!.length > 6
                                                ? null
                                                : "Por favor verifique sua senha, ela deve conter pelo menos 6 caracteres";
                                          },
                                          controller:
                                              passwordTextEdittingController,
                                        ),
                                      ))
                                ],
                              ),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      1.8,
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Lembrar de mim",
                              style: TextStyle(color: AppColors.green),
                            ),
                            Checkbox(
                              side: BorderSide(color: AppColors.green),
                              value: isRememberPassword,
                              activeColor: Colors.green,
                              onChanged: (newValue) =>
                                  changeIsRememberValue(newValue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                      Container(
                        //padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text(
                                  "Criar conta",
                                  style: TextStyle(
                                    color: AppColors.green,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                  ),
                                )),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPassword()));
                                },
                                child: Text(
                                  "Recuperar senha",
                                  style: TextStyle(
                                    color: AppColors.green,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
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
