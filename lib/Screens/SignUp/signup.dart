import 'package:app_mental/Services/database.dart';
import 'package:app_mental/Services/userService.dart';
import 'package:app_mental/animation/FadeAnimation.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  late DateTime now;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEdittingController =
      new TextEditingController();
  TextEditingController emailTextEdittingController =
      new TextEditingController();
  TextEditingController passwordTextEdittingController =
      new TextEditingController();

  showSnackbar(String message, Color color) {
    final snackBar = SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  signMeUp() async {
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
    UserService()
        .signupWithEmailAndPasswordAndName(userEmail, userName, userPassword)
        .then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showSnackbar('Usuário cadastrado com sucesso!', Colors.green);
      Navigator.pushNamedAndRemoveUntil(
          context, "/sign-in", (Route<dynamic> route) => false);
    }).catchError((error) {
      showSnackbar(error.toString(), Colors.red);
    });
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
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.bottomCenter,
                        image: AssetImage('assets/images/background.png'),
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
