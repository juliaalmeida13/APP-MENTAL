import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChartWeekScreen extends StatelessWidget {
  static const routeName = '/chart-result-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final title = routeArgs['title'];
    final questName = routeArgs['questName'];
    final questCode = routeArgs['questCode'];

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(title)),
        backgroundColor: kTextColorGreen,
        shadowColor: Color.fromRGBO(1, 1, 1, 0),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .25,
                child: BarChart(
                  BarChartData(
                    backgroundColor: Colors.white,
                    barGroups: [
                      generateGroupData(0, 1),
                      generateGroupData(1, 10),
                      generateGroupData(2, 18),
                      generateGroupData(3, 4),
                      generateGroupData(4, 11),
                      generateGroupData(5, 0),
                    ],
                    borderData: FlBorderData(
                        border: const Border(
                            bottom: BorderSide(), left: BorderSide())),
                    gridData: FlGridData(drawVerticalLine: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                          axisNameWidget: Text("Semana"),
                          sideTitles: _bottomTitles),
                      leftTitles: AxisTitles(
                        axisNameWidget: Text(questCode),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2,
                          reservedSize:
                              MediaQuery.of(context).size.height * .03,
                        ),
                      ),
                      topTitles: AxisTitles(
                          axisNameWidget: Text(questName),
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                  ),
                ),
              ),
              Text(
                  "Este texto deverá aparecer logo abaixo do gráfico com os resultados da escala $questCode"),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: -1 == x ? [0] : [],
      barRods: [
        BarChartRodData(
            toY: y.toDouble(),
            borderRadius: BorderRadius.zero,
            width: 15,
            color: AppColors.verdementa),
      ],
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String xTitle = '';
          switch (value.toInt()) {
            case 0:
              xTitle = '1';
              break;
            case 1:
              xTitle = '3';
              break;
            case 2:
              xTitle = '5';
              break;
            case 3:
              xTitle = '7';
              break;
            case 4:
              xTitle = '9';
              break;
            case 5:
              xTitle = '11';
              break;
          }
          return Text(
            xTitle,
            style: TextStyle(fontSize: 10),
          );
        },
      );
}
