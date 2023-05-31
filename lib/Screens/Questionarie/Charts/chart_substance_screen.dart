import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../model/score.dart';
import 'SleepScreen/Widgets/substance_chart.dart';

class ChartSubstanceScreen extends StatefulWidget {
  static const routeName = '/chart-substance-screen';

  @override
  State<ChartSubstanceScreen> createState() => _ChartSubstanceScreenState();
}

class _ChartSubstanceScreenState extends State<ChartSubstanceScreen> {
  List<bool> isOpen = List.filled(10, false);
  List<String> substanceList = [
    "Tabaco",
    "Álcool",
    "Maconha",
    "Cocaina/Crack",
    "Ecstase",
    "Inalantes",
    "Hipnóticos/Sedativos",
    "Alucinógenos",
    "Opióides",
    "Outras Substâncias",
  ];

  List<ExpansionPanel> createExpansionPanelList(List<Score> scoreList) {
    List<ExpansionPanel> expansionPanelList = [];
    for (int i = 0; i < substanceList.length; i++) {
      expansionPanelList.add(
        ExpansionPanel(
            headerBuilder: ((context, isExpanded) => Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    substanceList[i],
                    style: isExpanded
                        ? TextStyle(fontSize: 22, fontWeight: FontWeight.w500)
                        : TextStyle(fontSize: 20),
                  ),
                )),
            body: SubstanceChart(
                scoreList: scoreList, substance: substanceList[i]),
            canTapOnHeader: true,
            isExpanded: isOpen[i]),
      );
    } //beck,dragon quest
    return expansionPanelList;
  }

  goPageBack(BuildContext context) {
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
          onPressed: () => goPageBack(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ExpansionPanelList(
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (int index, bool isExpanded) {
                      for (int i = 0; i < isOpen.length; i++) {
                        setState(() {
                          isOpen[i] = (i == index) ? !isExpanded : false;
                        });
                      }
                    },
                    children: createExpansionPanelList(scoreList),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
