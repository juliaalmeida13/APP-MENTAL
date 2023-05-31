import 'package:app_mental/Screens/Questionarie/Charts/SleepScreen/Widgets/date_picker.dart';
import 'package:app_mental/Services/sleepService.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../helper/constants.dart';
import '../../../../model/sleep_diary.dart';
import 'Widgets/efficiency_card.dart';
import 'Widgets/more_info_card.dart';

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

  String getSleepyTime() {
    Duration tryToSleep = Duration(
        hours: int.parse(sleepData.tryToSleep.substring(0, 2)),
        minutes: int.parse(sleepData.tryToSleep.substring(3, 5)));
    Duration whileToSleep = Duration(
        hours: int.parse(sleepData.whileToSleep.substring(0, 2)),
        minutes: int.parse(sleepData.whileToSleep.substring(3, 5)));
    Duration sleepyTime = whileToSleep + tryToSleep;
    return sleepyTime.toString();
  }

  goBackPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/quests-screen");
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
          onPressed: () => goBackPage(context),
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
                      EfficiencyCard(
                        sleepyTime: getHourFormatted(getSleepyTime()),
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
                      MoreInfoCard(
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
