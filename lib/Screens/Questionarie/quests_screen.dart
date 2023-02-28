import 'package:app_mental/Screens/ChatRoom/Widgets/calendar.dart';
import 'package:app_mental/Screens/Questionarie/Widgets/app_body_widget.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:app_mental/escalas/assist/assist_screen.dart';
import 'package:app_mental/escalas/assistn2/assistn2_screen.dart';
import 'package:app_mental/escalas/mdq/mdq_screen.dart';
import 'package:app_mental/escalas/pcl5/pcl5_screen.dart';
import 'package:app_mental/escalas/phq15/phq15_screen.dart';
import 'package:app_mental/escalas/promisAnsiedade/promisAnsi_screen.dart';
import 'package:app_mental/escalas/promisn1/promisn1_screen.dart';
import 'package:app_mental/escalas/promisn2/promisn2_screen.dart';
import 'package:app_mental/escalas/pset/pset_screen.dart';
import 'package:app_mental/escalas/psqi/psqi_screen.dart';
import 'package:app_mental/escalas/questSD1/questSD1_screen.dart';
import 'package:app_mental/escalas/questSD2/questSD2_screen.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

// Constroi a tela da lista de cards de escalas/questionários disponíveis ao usuário
class QuestsScreen extends StatefulWidget {
  static const routeName = '/quests-screen';

  @override
  _QuestsScreenState createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream<QuerySnapshot<Object?>>? questsAnsweredRoomsStream;
  Stream<QuerySnapshot<Object?>>? questsUnansweredRoomsStream;

  //Lista de Cards de Escalas/Questionários disponíveis
  Widget questsRoomList(Stream<QuerySnapshot<Object?>>? stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // Caso houver algo, para cada escala/questionário que existir no banco de dados, irá construir um QuestRoomTile.
        return snapshot.hasData && snapshot.data!.docs.length > 0
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return QuestRoomTile(
                    snapshot.data!.docs[index].get("questName"),
                    snapshot.data!.docs[index].get("questId"),
                    snapshot.data!.docs[index].get("availableAt").toDate(),
                    snapshot.data!.docs[index].get("userEscala"),
                    snapshot.data!.docs[index].get("answeredUntil"),
                    snapshot.data!.docs[index].get("unanswered?"),
                    Constants.myEmail,
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfo().whenComplete(() {
      setState(() {});
    });
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameInSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailInSharedPreference();
    Constants.myEmail = Constants.myEmail.trim();
    databaseMethods
        .getAnsweredQuests(FirebaseAuth.instance.currentUser!.uid)
        .then((val) {
      setState(() {
        questsAnsweredRoomsStream = val;
      });
    });
    databaseMethods
        .getUnansweredQuests(FirebaseAuth.instance.currentUser!.uid)
        .then((val) {
      setState(() {
        questsUnansweredRoomsStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(Constants.myEmail + "a");
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(color: kTextColorGreen),
              backgroundColor: Colors.white,
              title: Text(
                'Suas Atividades',
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
                            child:
                                FittedBox(child: new Tab(text: 'Nessa semana')),
                          ),
                          new Container(
                            height: 50.0,
                            child:
                                FittedBox(child: new Tab(text: 'Respondidos')),
                          ),
                        ],
                      )))),
          body: TabBarView(
            children: [
              questsRoomList(questsUnansweredRoomsStream),
              questsRoomList(questsAnsweredRoomsStream),
            ],
          ),
        ));
  }
}

// Caso a escala/questionário estiver planejado para a semana atual, constroi-se um card para a lista.
class QuestRoomTile extends StatelessWidget {
  final String questName;
  final String questId;
  final DateTime availableAt;
  final String userEscala;
  final int answeredUntil;
  final bool unanswered;
  final String userEmail;
  final DateTime _now = DateTime.now();
  final Map<String, dynamic> routes = {
    "pn1": Promisn1Screen.routeName,
    "pn2": Promisn2Screen.routeName,
    "pset": PsetScreen.routeName,
    "pcl5": Pcl5Screen.routeName,
    "questSD1": QuestSD1Screen.routeName,
    "questSD2": QuestSD2Screen.routeName,
    "mdq": MdqScreen.routeName,
    "pn2A": PromisAnsiScreen.routeName,
    "phq15": Phq15Screen.routeName,
    "psqi": PsqiScreen.routeName,
    "assist": AssistScreen.routeName,
    "assistn2": Assistn2Screen.routeName,
  };

  QuestRoomTile(
    this.questName,
    this.questId,
    this.availableAt,
    this.userEscala,
    this.answeredUntil,
    this.unanswered,
    this.userEmail,
  );

  @override
  Widget build(BuildContext context) {
    print("aa aa aa $availableAt");
    var nextSunday = getNextSunday(availableAt);
    print(nextSunday);

    print(questName);
    // Caso a escala/questionário seja planejada para a semana atual, constroi-se um card
    if (_now.isAfter(availableAt) && _now.isBefore(nextSunday)) {
      return QuizCard(
          title: questName,
          completed: unanswered
              ? "Questões respondidas: $answeredUntil"
              : "Completado!",
          now: _now,
          expirationDate: nextSunday,
          onTap: () {
            if (unanswered) {
              print('userEmail no navigator: $userEmail' + "//");
              Navigator.of(context).pushNamed(routes[questId], arguments: {
                'title': questName,
                'userEscala': userEscala,
                'answeredUntil': answeredUntil,
                'email': userEmail,
              });
            }
          });
    } else {
      return Container();
    }
  }
}
