import 'package:app_mental/Services/scaleService.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/material.dart';

import '../../Services/sleepService.dart';
import '../../constants.dart';
import '../../model/scale.dart';
import 'Widgets/generic_quest_room_tile.dart';
import 'Widgets/quest_room_tile.dart';

// Constroi a tela da lista de cards de escalas/questionários disponíveis ao usuário
class QuestsScreen extends StatefulWidget {
  static const routeName = '/quests-screen';

  @override
  _QuestsScreenState createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  List<Scale> answeredQuests = [];
  List<Scale> unansweredQuests = [];
  List<Scale> allAnsweredQuests = [];

  //Lista de Cards de Escalas/Questionários disponíveis
  Widget questsRoomList(List<Scale> scaleList) {
    return ListView.builder(
      itemCount: scaleList.length,
      itemBuilder: (context, index) {
        return QuestRoomTile(
            scaleList[index].questionnaireName!,
            scaleList[index].questionnaireCode!,
            DateTime.parse(scaleList[index].availableAt!),
            scaleList[index].userScale!,
            scaleList[index].answeredUntil!,
            scaleList[index].unanswered!,
            scaleList[index].week!,
            scaleList[index].answeredAt != null
                ? DateTime.parse(scaleList[index].answeredAt!)
                : DateTime.now(),
            Constants.myEmail);
      },
    );
  }

  Widget allQuestsRoomList(List<Scale> scaleList) {
    return ListView.builder(
      itemCount: scaleList.length,
      itemBuilder: (context, index) {
        return GenericQuestRoomTile(scaleList[index].questionnaireName!,
            scaleList[index].questionnaireCode!, Constants.myEmail);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfoAndQuests().whenComplete(() {
      setState(() {});
    });
  }

  getUserInfoAndQuests() async {
    Constants.myName = await HelperFunctions.getUserNameInSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailInSharedPreference();
    ScaleService()
        .listUnansweredQuestionnaires(Constants.myEmail)
        .then((questionnaires) {
      setState(() {
        unansweredQuests.addAll(questionnaires);
      });
    }).catchError((error) {
      print(error);
    });
    ScaleService()
        .listAnsweredQuestionnaires(Constants.myEmail)
        .then((questionnaires) {
      setState(() {
        answeredQuests.addAll(questionnaires);
      });
    }).catchError((error) {
      print(error);
    });
    ScaleService()
        .listAllAnsweredQuestionnaires(Constants.myEmail)
        .then((questionnairesNames) {
      setState(() {
        allAnsweredQuests.addAll(questionnairesNames);
        allAnsweredQuests.add(Scale.fromJson({
          "questionnaireCode": "sleepQuestionnaire",
          "questionnaireName": "Diário do Sono",
        }));
      });
    }).catchError((error) {
      print(error);
    });
    SleepService()
        .isSleepDiaryAnsweredToday(Constants.myEmail)
        .then((answered) {
      if (answered) {
        answeredQuests.add(Scale.fromJson({
          "questionnaireCode": "sleepQuestionnaire",
          "questionnaireName": "Diário do Sono",
          "availableAt": DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day - 1)
              .toString(),
          "userScale": "sleep",
          "answeredUntil": 0,
          "week": "",
          "unanswered": false
        }));
      } else {
        unansweredQuests.add(Scale.fromJson({
          "questionnaireCode": "sleepQuestionnaire",
          "questionnaireName": "Diário do Sono",
          "availableAt": DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day - 1)
              .toString(),
          "userScale": "sleep",
          "answeredUntil": 0,
          "week": "",
          "unanswered": true
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            iconTheme: IconThemeData(color: kTextColorGreen),
            backgroundColor: Colors.white,
            title: Text(
              'Questionários',
              style: AppTextStyles.tituloatividades,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName('/logged-home'));
                Navigator.of(context).pushNamed("/logged-home");
              },
            ),
            bottom: new PreferredSize(
                preferredSize: new Size(300.0, 50.0),
                child: new Container(
                    child: new TabBar(
                  indicatorColor: AppColors.verdeclaro,
                  labelStyle: AppTextStyles.titulotab,
                  labelColor: Colors.black,
                  tabs: [
                    new Container(
                      height: 50.0,
                      child: FittedBox(child: new Tab(text: 'A responder')),
                    ),
                    new Container(
                      height: 50.0,
                      child:
                          FittedBox(child: new Tab(text: 'Avaliação semanal')),
                    ),
                    new Container(
                      height: 50.0,
                      child: FittedBox(child: new Tab(text: 'Avaliação geral')),
                    ),
                  ],
                )))),
        body: TabBarView(
          children: [
            questsRoomList(unansweredQuests),
            questsRoomList(answeredQuests),
            allQuestsRoomList(allAnsweredQuests),
          ],
        ),
      ),
    );
  }
}
