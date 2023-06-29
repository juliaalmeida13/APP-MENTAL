import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';

import '../../../Services/questionnaireService.dart';
import '../../../constants.dart';

class ChartGeneralScreen extends StatefulWidget {
  static const routeName = '/chart-general-screen';

  @override
  State<ChartGeneralScreen> createState() => _ChartGeneralScreenState();
}

class _ChartGeneralScreenState extends State<ChartGeneralScreen> {
  Future<String> getLegend(questCode) async {
    return await QuestionnaireService().getChartLegend(questCode);
  }

  goBackPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/quests-screen");
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final questName = routeArgs['questName'];
    final questCode = routeArgs['questCode'];
    final scoreList = routeArgs['scoreList'];
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text("Avaliação $questName")),
        backgroundColor: kTextColorGreen,
        shadowColor: Color.fromRGBO(1, 1, 1, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => goBackPage(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .25,
                  child: BarChart(
                    BarChartData(
                      backgroundColor: Colors.white,
                      barGroups: generateGroupData(scoreList),
                      borderData: FlBorderData(
                          border: const Border(
                              bottom: BorderSide(), left: BorderSide())),
                      gridData: FlGridData(drawVerticalLine: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                            axisNameWidget: Text("Semana"),
                            sideTitles: _bottomTitles),
                        leftTitles: AxisTitles(
                          axisNameWidget: Text("Soma"),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize:
                                MediaQuery.of(context).size.height * .05,
                          ),
                        ),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: false,
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                  future: getLegend(questCode),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Html(
                        data: snapshot.data.toString(),
                        style: {
                          "tr": Style(
                              padding: const EdgeInsets.all(2),
                              border: Border.all(color: Colors.black)),
                          "td": Style(
                            padding: const EdgeInsets.all(2),
                          ),
                        },
                        customRenders: {tableMatcher(): tableRender()},
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> generateGroupData(scoreList) {
    List<BarChartGroupData> barChartGroupDataList = [];
    for (int i = 0; i < scoreList.length; i++) {
      List<String> week = scoreList[i].week.split("Semana ");
      int weekNumber = int.parse(week[1]);
      barChartGroupDataList.add(
        BarChartGroupData(
          x: weekNumber,
          barRods: [
            BarChartRodData(
                toY: double.parse(scoreList[i].score),
                borderRadius: BorderRadius.zero,
                width: 15,
                color: AppColors.verdementa),
          ],
        ),
      );
    }
    return barChartGroupDataList;
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return Text(
            value.toInt().toString(),
            style: TextStyle(fontSize: 14),
          );
        },
      );
}
