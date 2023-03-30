import 'package:app_mental/Screens/ChatRoom/Widgets/calendar.dart';
import 'package:app_mental/Screens/Questionarie/Widgets/app_body_widget.dart';
import 'package:app_mental/Services/scaleService.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:app_mental/escalas/question_screen.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Services/questionnaireService.dart';
import '../../constants.dart';
import '../../model/scale.dart';

// Constroi a tela da lista de cards de escalas/questionários disponíveis ao usuário
class QuestsScreen extends StatefulWidget {
  static const routeName = '/quests-screen';

  @override
  _QuestsScreenState createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  List<Scale> answeredQuests = [];
  List<Scale> unansweredQuests = [];

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
            scaleList[index].notificationStatus!,
            scaleList[index].week!,
            Constants.myEmail,
          );
        });
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
        unansweredQuests = questionnaires;
      });
    }).catchError((error) {
      print(error);
    });
    ScaleService()
        .listAnsweredQuestionnaires(Constants.myEmail)
        .then((questionnaires) {
      setState(() {
        answeredQuests = questionnaires;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          child: FittedBox(child: new Tab(text: 'Respondidos')),
                        ),
                      ],
                    )))),
        body: TabBarView(
          children: [
            questsRoomList(unansweredQuests),
            questsRoomList(answeredQuests),
          ],
        ),
      ),
    );
  }
}

// Caso a escala/questionário estiver planejado para a semana atual, constroi-se um card para a lista.
class QuestRoomTile extends StatelessWidget {
  final String questName;
  final String questCode;
  final DateTime availableAt;
  final String userEscala;
  final int answeredUntil;
  final bool unanswered;
  final bool notificationStatus;
  final String week;
  final String userEmail;
  final DateTime _now = DateTime.now();

  QuestRoomTile(
    this.questName,
    this.questCode,
    this.availableAt,
    this.userEscala,
    this.answeredUntil,
    this.unanswered,
    this.notificationStatus,
    this.week,
    this.userEmail,
  );

  @override
  Widget build(BuildContext context) {
    var nextSunday = getNextSunday(availableAt);

    // Caso a escala/questionário seja planejada para a semana atual, constroi-se um card
    if (_now.isAfter(availableAt) && _now.isBefore(nextSunday)) {
      return QuizCard(
          notificationStatus: notificationStatus,
          title: "$questName - $week",
          completed: unanswered
              ? "Questões respondidas: $answeredUntil"
              : "Completado!",
          now: _now,
          expirationDate: nextSunday,
          onTap: () async {
            if (unanswered) {
              List<dynamic> _questions = [];
              await QuestionnaireService()
                  .getQuestions(questCode)
                  .then((values) {
                values.forEach((value) {
                  _questions.add(value);
                });
              }).whenComplete(() => Navigator.of(context)
                          .pushNamed(QuestionScreen.routeName, arguments: {
                        'title': "$questName - $week",
                        'userEscala': userEscala,
                        'answeredUntil': answeredUntil,
                        'email': userEmail,
                        'questions': _questions,
                        'questionnaireCode': questCode
                      }));
            }
          });
    } else {
      return Container();
    }
  }
}
