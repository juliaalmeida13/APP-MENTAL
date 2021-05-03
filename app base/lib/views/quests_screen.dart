import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import '../escalas/promisn1/promisn1_screen.dart';
//import './promisn2_screen.dart';

class QuestsScreen extends StatelessWidget {
  static const routeName = '/quests-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionários'),
      ),
      body: Container(
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
          )),
    );
  }
}
