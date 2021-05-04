import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/database.dart';
import '../escalas/promisn1/promisn1_screen.dart';
import '../helper/helperfuncions.dart';
//import './promisn2_screen.dart';

class QuestsScreen extends StatefulWidget {
  static const routeName = '/quests-screen';

  @override
  _QuestsScreenState createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  QuerySnapshot dominios;

  var dom1;

  String userEmail;

  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {
    getEmail();
    print(userEmail);

    super.initState();
  }

  getEmail() async {
    userEmail = await HelperFunctions.getUserEmailInSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    print(dominios.docs[0].get("dom4"));

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
              /*if (dom1 > 4)
                ListTile(
                  title: Text('Promis Nível 2'),
                  onTap: () {},
                ),*/
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
