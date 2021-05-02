import 'package:chat_app_tutorial/Perfil/Widgets/Informacoes/info.dart';
import 'package:chat_app_tutorial/Perfil/Widgets/appbar/app_bar_widget.dart';
import 'package:chat_app_tutorial/Perfil/Widgets/navegacao/navegacao.dart';
import 'package:flutter/material.dart';

//Tela de perfil

class ProfilePage extends StatefulWidget {
  //HomePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: Info(),
        );
  }
}
