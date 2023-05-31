import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EfficiencyContainer extends StatefulWidget {
  final double sleepEfficiency;

  EfficiencyContainer({required this.sleepEfficiency});

  @override
  State<EfficiencyContainer> createState() => _EfficiencyContainerState();
}

class _EfficiencyContainerState extends State<EfficiencyContainer> {
  bool isTouched = false;
  Widget pieChart() {
    return Expanded(
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                isTouched = event.isInterestedForInteractions;
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
    );
  }
}
