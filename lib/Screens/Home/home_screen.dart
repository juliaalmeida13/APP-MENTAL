import 'package:app_mental/Screens/Home/Widgets/body.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../Services/notificationService.dart';
import '../../Services/scaleService.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';
import '../Questionarie/quests_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userEmail;

  @override
  void initState() {
    getUserEmail().then((_) {
      NotificationService.init(initSchedule: true).then(
        (value) {
          scheduleQuestionnaireNotifications();
        },
      );
    });
    listenNotifications();
    super.initState();
  }

  listenNotifications() =>
      NotificationService.onNotifications.stream.listen(onClickedNotification);

  onClickedNotification(String? payload) {
    Navigator.of(context).pushNamed("$payload");
  }

  scheduleQuestionnaireNotifications() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await FlutterLocalNotificationsPlugin().pendingNotificationRequests();
    if (userEmail != null && pendingNotificationRequests.length == 0) {
      ScaleService().getQuestionnaireDateNotification(userEmail!).then((dates) {
        var i = 1;
        dates.forEach((date) {
          NotificationService.showScheduleWeekNotification(
            id: i,
            title: "AppMental",
            body: "Novo Questionário disponível!",
            payload: "/quests-screen",
            scheduleDate: DateTime.parse(date),
          );
        });
      });
    }
    NotificationService.showScheduleDayNotification(
      id: 0,
      title: "AppMental",
      body: "Bom dia! Entre no aplicativo para responder o diário do sono!",
      payload: "/sleep-diary",
    );
  }

  getUserEmail() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((value) {
      setState(() {
        userEmail = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
        backgroundColor: kTextColorGreen,
        shadowColor: Color.fromRGBO(1, 1, 1, 0),
      ),
      drawer: AppDrawer(key: Key("drawer")),
      body: Body(),
    );
  }
}
