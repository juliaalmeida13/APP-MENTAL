import 'package:app_mental/Screens/ChatRoom/Widgets/calendar.dart';
import 'package:app_mental/Services/auth.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/animation/FadeAnimation.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  //final Function toggle;
  //SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  late DateTime now;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEdittingController =
      new TextEditingController();
  TextEditingController emailTextEdittingController =
      new TextEditingController();
  TextEditingController passwordTextEdittingController =
      new TextEditingController();

  signMeUp() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String userEmail = emailTextEdittingController.text;
    String userName = userNameTextEdittingController.text;
    String userPassword = passwordTextEdittingController.text;

    setState(() {
      isLoading = true;
    });
    final snackBar = SnackBar(
        content: new Row(
      children: <Widget>[
        new CircularProgressIndicator(),
        new Text("    Criando conta...")
      ],
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    authMethods
        .signupWithEmailAndPasswordAndName(userName, userEmail, userPassword)
        .then((result) {
      if (result != null && result.user != null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        User? user = result.user;
        HelperFunctions.saveUserInfoToSharedPrefs(user);
        CreateQuests();
        Navigator.pushNamedAndRemoveUntil(
            context, "/logged-home", (Route<dynamic> route) => false);
      } else {
        final snackBar = SnackBar(
            content:
                Text('Email já em uso!', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void CreateQuests() {
    now = DateTime.now();
    //var firstDay = getNextSunday(now);
    //for test purpose
    var firstDay = now;
    //add promisn1 every other week, odd numbers
    for (var i = 1; i <= 11; i += 2) {
      String userEscala = 'promisN1_week$i';
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pn1",
        "questName": "Escala PROMIS Nível 1 - Semana $i",
        "userEscala": userEscala,
        "availableAt": addHours(day: firstDay, n: i - 1),
        "answeredUntil": 0,
      };
      DatabaseMethods()
          .createQuest(userEscala, questMap, emailTextEdittingController.text);
    }

    //add pset every other week, even numbers (except 6 and 10)
    for (var i = 1; i <= 12; i += 2) {
      if (i != 6 && i != 10) {
        String userEscala = 'pset_week$i';
        Map<String, dynamic> questMap = {
          "unanswered?": true,
          "questId": "pset",
          "questName": "Pergunta Eventos Traumáticos - Semana $i",
          "userEscala": userEscala,
          "availableAt": addHours(day: firstDay, n: i),
          "answeredUntil": 0,
        };
        DatabaseMethods().createQuest(
            userEscala, questMap, emailTextEdittingController.text);
      }
    }
    //add quesi 6th week
    String userEscala = 'quesi_week6';
    Map<String, dynamic> questMap = {
      "unanswered?": true,
      "questId": "quesi",
      "questName": "Questionário Sobre Traumas na Infância - Semana 6",
      "userEscala": userEscala,
      "availableAt": addHours(day: firstDay, n: 5),
      "answeredUntil": 0,
    };
    DatabaseMethods()
        .createQuest(userEscala, questMap, emailTextEdittingController.text);

    //add questSD1 1st week
    String userEscala1 = 'questSD1_week1';
    Map<String, dynamic> questMap1 = {
      "unanswered?": true,
      "questId": "questSD1",
      "questName": "Questionário Sociodemográfico (1) - Semana 1",
      "userEscala": userEscala1,
      "availableAt": addHours(day: firstDay, n: 0),
      "answeredUntil": 0,
    };
    DatabaseMethods()
        .createQuest(userEscala1, questMap1, emailTextEdittingController.text);

    //add questSD2 2nd week
    String userEscala2 = 'questSD2_week2';
    Map<String, dynamic> questMap2 = {
      "unanswered?": true,
      "questId": "questSD2",
      "questName": "Questionário Sociodemográfico (2) - Semana 2",
      "userEscala": userEscala2,
      "availableAt": addHours(day: firstDay, n: 1),
      "answeredUntil": 0,
    };
    DatabaseMethods()
        .createQuest(userEscala2, questMap2, emailTextEdittingController.text);

    //add contact
    Map<String, dynamic> contactMap = {
      "name": "Emergência",
      "number": 800,
    };
    DatabaseMethods()
        .createContactList(contactMap, emailTextEdittingController.text);
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 2
                                    ? "Please Provide a valid UserName"
                                    : null;
                              },
                              controller: userNameTextEdittingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Usuário"),
                            ),
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Please provide a valid email";
                              },
                              controller: emailTextEdittingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Email"),
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Please provide password 6+ character";
                              },
                              controller: passwordTextEdittingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Senha"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            "Esqueceu a Senha?",
                            style: simpleTextStyle(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          signMeUp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xFF007EA7),
                              const Color(0xFF007EA7),
                            ]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Criar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Entrar com o Google",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Já possui uma conta? ",
                              style: mediumTextStyle()),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Entrar Agora",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }*/

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
                        image: AssetImage('assets/images/background.png'),
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
                                                    color: Colors.grey[100]!))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Nome de Usuário",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                          validator: (val) {
                                            return val!.isEmpty ||
                                                    val.length < 2
                                                ? "O nome de usuário não pode ser vazio ou ter menos que 2 caracteres"
                                                : null;
                                          },
                                          controller:
                                              userNameTextEdittingController,
                                        ),
                                      )),
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
                                                : "A senha não pode ter menos que 6 caracteres";
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
                              signMeUp();
                            },
                            child: Center(
                              child: Text("Criar conta",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      2,
                      GestureDetector(
                        onTap: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));*/
                          Navigator.pop(context);
                        },
                        child: Container(
                          //padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Fazer login",
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
