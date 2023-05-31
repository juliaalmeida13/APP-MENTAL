import 'package:app_mental/Screens/Questionarie/Charts/SleepScreen/Widgets/time_and_text.dart';
import 'package:app_mental/Screens/Questionarie/Charts/SleepScreen/Widgets/time_and_text_final.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SleepDataContainer extends StatelessWidget {
  final String sleepyTime;
  final String wakeUpTime;
  final int timesWokeUp;
  final String timeAwake;
  final String totalTimeSleep;

  SleepDataContainer(
      {required this.sleepyTime,
      required this.timeAwake,
      required this.timesWokeUp,
      required this.totalTimeSleep,
      required this.wakeUpTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.6,
      height: double.infinity,
      child: Column(children: [
        Expanded(
          child: Container(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TimeAndText(
                          icon: CupertinoIcons.moon,
                          time: sleepyTime,
                          text: "Horário do adormecer",
                        ),
                        TimeAndText(
                          icon: CupertinoIcons.cloud_sun,
                          time: wakeUpTime,
                          text: "Horário do despertar",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              timesWokeUp.toString(),
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 24),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                                child: AutoSizeText("Despertares noturnos")),
                          ],
                        ),
                        TimeAndText(
                          icon: Icons.access_time_outlined,
                          time: timeAwake,
                          text: "Tempo total do despertar",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: TimeAndTextFinal(
            icon: Icons.access_time_filled,
            time: totalTimeSleep,
            text: "Tempo total de sono",
          ),
        ),
      ]),
    );
  }
}
