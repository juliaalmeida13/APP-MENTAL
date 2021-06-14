import 'package:chat_app_tutorial/Screens/Questionarie/Widgets/app_bar_widget.dart';
import 'package:chat_app_tutorial/Screens/Questionarie/Widgets/app_body_widget.dart';
import 'package:flutter/material.dart';
//import './promisn2_screen.dart';

class QuestsScreen extends StatelessWidget {
  static const routeName = '/quests-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Expanded(
            child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              children: [
                QuizCard(),
              ],
            ),
          )),

      /*Container(
          width: double.infinity,
          child: Column(
            children: [
              ListTile(
                title: Text('PROMIS Nível 1'),
                onTap: () {
                  Navigator.of(context).pushNamed(Promisn1Screen.routeName,
                      arguments: {'title': 'PROMIS Nível 1'});
                },
              ),
              Divider(thickness: 2.0),
              /*ListTile(
                title: Text('PROMIS Nível 2'),
                onTap: () {
                  Navigator.of(context).pushNamed(Promisn2Screen.routeName,
                      arguments: {'title': 'PROMIS Nível 2'});
                },
              ),*/
              Divider(thickness: 2.0),
            ],
          )),*/
    );
  }
}
