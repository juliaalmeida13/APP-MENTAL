import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../constants.dart';

class ChartPromisScreen extends StatefulWidget {
  static const routeName = '/chart-promis-screen';

  @override
  State<ChartPromisScreen> createState() => _ChartPromisScreenState();
}

class _ChartPromisScreenState extends State<ChartPromisScreen> {
  String selectedDominionName = "";
  List listDominion = [
    {'dominionName': 'Depressão', 'dominionNumber': 1},
    {'dominionName': 'Raiva', 'dominionNumber': 2},
    {'dominionName': 'Mania', 'dominionNumber': 3},
    {'dominionName': 'Ansiedade', 'dominionNumber': 4},
    {'dominionName': 'Sintomas Somáticos', 'dominionNumber': 5},
    {'dominionName': 'Ideação Suicida', 'dominionNumber': 6},
    {'dominionName': 'Psicose', 'dominionNumber': 7},
    {'dominionName': 'Distúrbios do Sono', 'dominionNumber': 8},
    {'dominionName': 'Memória', 'dominionNumber': 9},
    {
      'dominionName': 'Pensamentos e comportamentos repetitivos',
      'dominionNumber': 10
    },
    {'dominionName': 'Dissociação', 'dominionNumber': 11},
    {'dominionName': 'Funcionamento da personalidade', 'dominionNumber': 12},
    {'dominionName': 'Uso de Substância', 'dominionNumber': 13},
  ];

  @override
  void initState() {
    super.initState();
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
        child: Column(
          children: [
            Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: DropdownButton<String>(
                    hint: selectedDominionName == ""
                        ? Text("Selecione o domínio")
                        : Text(
                            selectedDominionName,
                          ),
                    items: listDominion.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['dominionName'],
                        child: Text(value['dominionName']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedDominionName = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
            selectedDominionName != ""
                ? Container(
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
                                        bottom: BorderSide(),
                                        left: BorderSide())),
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
                                          MediaQuery.of(context).size.height *
                                              .03,
                                    ),
                                  ),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                              "Este texto deverá aparecer logo abaixo do gráfico (legenda)"),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> generateGroupData(scoreList) {
    List<BarChartGroupData> barChartGroupDataList = [];
    int dominionNumber = 0;
    for (int i = 0; i < listDominion.length; i++) {
      if (listDominion[i]['dominionName'] == selectedDominionName) {
        dominionNumber = listDominion[i]['dominionNumber'];
      }
    }
    for (int i = 0; i < scoreList.length; i++) {
      if (scoreList[i].domain == dominionNumber) {
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
