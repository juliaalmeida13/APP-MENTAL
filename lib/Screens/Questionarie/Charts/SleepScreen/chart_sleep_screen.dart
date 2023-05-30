import 'package:app_mental/Screens/Questionarie/Charts/SleepScreen/Widgets/date_picker.dart';
import 'package:app_mental/Services/sleepService.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../helper/constants.dart';
import '../../../../model/sleep_diary.dart';
import 'Widgets/first_card.dart';
import 'Widgets/second_card.dart';

class ChartSleepScreen extends StatefulWidget {
  static const routeName = '/chart-sleep-screen';

  @override
  State<ChartSleepScreen> createState() => _ChartSleepScreenState();
}

class _ChartSleepScreenState extends State<ChartSleepScreen> {
  SleepDiary sleepData = SleepDiary(
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
  bool datePicked = false;
  List<DateTime> questionnaireAnswerDates = [];

  @override
  void initState() {
    SleepService()
        .getSleepQuestionnaireDates(Constants.myEmail)
        .then((dates) => setState(() {
              questionnaireAnswerDates = dates;
            }));
    super.initState();
  }

  getHourFormatted(String time) {
    if (time != "") {
      int hours = int.parse(time.substring(0, 2));
      if (hours < 12) {
        return "${time.substring(0, 5)} AM";
      }
      return "${time.substring(0, 5)} PM";
    }
    return time;
  }

  getHourInMinutes(String time) {
    if (time != "") {
      int hours = int.parse(time.substring(0, 2));
      if (hours > 0) {
        return "${time.substring(0, 2)}h ${time.substring(3, 5)}m";
      }
      return "${time.substring(3, 5)}min";
    }
    return time;
  }

  setSleepData(SleepDiary newValue) {
    setState(() {
      sleepData = newValue;
      datePicked = true;
    });
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
            SizedBox(
              height: 20,
            ),
            DatePicker(
              setSleepData: setSleepData,
              questionnaireAnswerDates: questionnaireAnswerDates,
              lastDayAnswered: questionnaireAnswerDates.length,
            ),
            datePicked
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      FirstCard(
                        gotoBed: getHourFormatted(sleepData.gotoBed),
                        wakeUpTime: getHourFormatted(sleepData.wakeUpTime),
                        timesWokeUp: sleepData.timesWokeUp!,
                        timeAwake: getHourInMinutes(sleepData.timeAwake!),
                        totalTimeSleep:
                            getHourInMinutes(sleepData.totalTimeSleep),
                        sleepEfficiency:
                            double.parse(sleepData.sleepEfficiency),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SecondCard(
                        tryToSleep: getHourFormatted(sleepData.tryToSleep),
                        gotoBed: getHourFormatted(sleepData.gotoBed),
                        spendInBed: getHourInMinutes(sleepData.spendInBed),
                        whileToSleep: getHourInMinutes(sleepData.whileToSleep),
                        sleepDuringDay:
                            getHourInMinutes(sleepData.sleepDuringDay),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
