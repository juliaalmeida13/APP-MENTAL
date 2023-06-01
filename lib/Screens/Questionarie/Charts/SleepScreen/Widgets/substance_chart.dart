import 'package:flutter/material.dart';

import '../../../../../model/score.dart';

class SubstanceChart extends StatefulWidget {
  final List<Score> scoreList;
  final String substance;

  SubstanceChart({required this.scoreList, required this.substance});

  @override
  State<SubstanceChart> createState() => _SubstanceChartState();
}

class _SubstanceChartState extends State<SubstanceChart> {
  bool hasData = true;

  List<Widget> createHorizontalBarList() {
    List<Widget> widgetList = [];
    for (int i = 0; i < widget.scoreList.length; i++) {
      List<String> substanceName = widget.scoreList[i].week.split(")");
      List<String> week = widget.scoreList[i].week.split("- ");
      if (widget.substance == substanceName[0].substring(1)) {
        widgetList.add(ChartLine(
            percentage: int.parse(widget.scoreList[i].score) / 39,
            week: week[1],
            score: widget.scoreList[i].score));
      }
    }
    if (widgetList.isEmpty) {
      setState(() {
        hasData = false;
      });
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: double.infinity,
        child: hasData
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Soma ASSIST",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: createHorizontalBarList(),
                    ),
                  ),
                ],
              )
            : Align(
                alignment: Alignment.center,
                child: Text("Sem dados", style: TextStyle(fontSize: 16))),
      ),
    );
  }
}

class ChartLine extends StatelessWidget {
  final double percentage;
  final String week;
  final String score;

  ChartLine({
    required this.percentage,
    required this.week,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.lightBlue,
                    height: 50,
                    width:
                        (MediaQuery.of(context).size.width - 65) * percentage,
                  ),
                  Container(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          week,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            score,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
