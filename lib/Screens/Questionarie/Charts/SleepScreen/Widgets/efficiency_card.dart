import 'package:app_mental/Screens/Questionarie/Charts/SleepScreen/Widgets/efficiency_container.dart';
import 'package:app_mental/Screens/Questionarie/Charts/SleepScreen/Widgets/sleep_data_container.dart';
import 'package:flutter/material.dart';

class EfficiencyCard extends StatelessWidget {
  final String sleepyTime;
  final String wakeUpTime;
  final int timesWokeUp;
  final String timeAwake;
  final String totalTimeSleep;
  final double sleepEfficiency;

  EfficiencyCard(
      {required this.sleepyTime,
      required this.wakeUpTime,
      required this.timesWokeUp,
      required this.timeAwake,
      required this.totalTimeSleep,
      required this.sleepEfficiency});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4,
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            EfficiencyContainer(sleepEfficiency: sleepEfficiency),
            SleepDataContainer(
                sleepyTime: sleepyTime,
                timeAwake: timeAwake,
                timesWokeUp: timesWokeUp,
                totalTimeSleep: totalTimeSleep,
                wakeUpTime: wakeUpTime)
          ],
        ),
      ),
    );
  }
}
