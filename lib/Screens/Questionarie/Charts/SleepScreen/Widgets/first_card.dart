import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FirstCard extends StatefulWidget {
  final String gotoBed;
  final String wakeUpTime;
  final int timesWokeUp;
  final String timeAwake;
  final String totalTimeSleep;
  final double sleepEfficiency;

  FirstCard(
      {required this.gotoBed,
      required this.wakeUpTime,
      required this.timesWokeUp,
      required this.timeAwake,
      required this.totalTimeSleep,
      required this.sleepEfficiency});

  @override
  State<FirstCard> createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
  int touchedIndex = -1;

  Widget pieChart() {
    return Expanded(
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 15,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: widget.sleepEfficiency,
            title: "${widget.sleepEfficiency.toString()}%",
            radius: isTouched ? 40.0 : 35.0,
            titleStyle: TextStyle(
              fontSize: isTouched ? 16.0 : 12.0,
              color: Colors.black,
              shadows: [Shadow(color: Colors.black, blurRadius: 2)],
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.black12,
            value: 100 - widget.sleepEfficiency,
            title: '',
            radius: 35.0,
          );
        default:
          throw Error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4,
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Eficiência do sono",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  pieChart(),
                ],
              ),
            ),
            Container(
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
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.moon,
                                      color: Colors.blue,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "${widget.gotoBed} PM",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text("Horário do adormecer"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.cloud_sun,
                                      color: Colors.blue,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "${widget.wakeUpTime} AM",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text("Horário do despertar"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                      widget.timesWokeUp.toString(),
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 24),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                        child: AutoSizeText(
                                            "Despertares noturnos")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      color: Colors.blue,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "${widget.timeAwake} min",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          FittedBox(
                                              child: Text(
                                                  "Tempo total do despertar")),
                                        ],
                                      ),
                                    ),
                                  ],
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
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                color: Colors.blue,
                              ),
                              Column(
                                children: [
                                  Text(
                                    widget.totalTimeSleep,
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 22),
                                  ),
                                  FittedBox(child: Text("Tempo total de sono")),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
