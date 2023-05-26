import 'package:app_mental/Services/sleepService.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../model/sleep.dart';
import 'Widgets/first_card.dart';
import 'Widgets/second_card.dart';

class ChartSleepScreen extends StatefulWidget {
  static const routeName = '/chart-sleep-screen';

  @override
  State<ChartSleepScreen> createState() => _ChartSleepScreenState();
}

class _ChartSleepScreenState extends State<ChartSleepScreen> {
  Sleep sleepData = Sleep(
      gotoBed: "",
      tryToSleep: "",
      whileToSleep: "",
      timesWokeUp: 0,
      timeAwake: "",
      wakeUpTime: "",
      spendInBed: "",
      sleepDuringDay: "",
      totalTimeSleep: "",
      sleepEfficiency: "0");

  @override
  void initState() {
    SleepService().getSleepQuestionnaireAnswersApp("a@a.com", "2023-05-25")
        //Constants.myEmail*/
        .then((value) {
      setState(() {
        sleepData = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text("Avaliação Diário do Sono")),
        backgroundColor: kTextColorGreen,
        shadowColor: Color.fromRGBO(1, 1, 1, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
            Navigator.of(context).pushNamed("/quests-screen");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //date picker
            SizedBox(
              height: 20,
            ),
            FirstCard(
                gotoBed: sleepData.gotoBed,
                wakeUpTime: sleepData.wakeUpTime,
                timesWokeUp: sleepData.timesWokeUp!,
                timeAwake: sleepData.timeAwake!,
                totalTimeSleep: sleepData.totalTimeSleep,
                sleepEfficiency: double.parse(sleepData.sleepEfficiency)),
            SizedBox(
              height: 20,
            ),
            SecondCard(
                tryToSleep: sleepData.tryToSleep,
                gotoBed: sleepData.gotoBed,
                spendInBed: sleepData.spendInBed,
                whileToSleep: sleepData.whileToSleep,
                sleepDuringDay: sleepData.sleepDuringDay),
          ],
        ),
      ),
    );
  }
}
