import 'package:app_mental/Screens/Home/Widgets/body.dart';
import 'package:app_mental/Services/auth.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthMethods authMethods = new AuthMethods();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: AppDrawer(key: Key("drawer")),
          appBar: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(color: kTextColorGreen),
              backgroundColor: Colors.white,
              title: Text(
                'Início',
                style: AppTextStyles.tituloatividades,
              ),
              bottom: new PreferredSize(
                  preferredSize: new Size(300.0, 50.0),
                  child: new Container(
                      width: 300.0,
                      child: new TabBar(
                        indicatorColor: AppColors.verdeclaro,
                        labelStyle: AppTextStyles.titulotab,
                        labelColor: Colors.black,
                        tabs: [
                          new Container(
                            height: 50.0,
                            child: new Tab(text: 'Leituras'),
                          ),
                          new Container(
                            height: 50.0,
                            child: new Tab(text: 'Outros'),
                          ),
                        ],
                      )))),
          body: TabBarView(
            children: [Cards(), Cards()],
          ),
        ));
  }
}
