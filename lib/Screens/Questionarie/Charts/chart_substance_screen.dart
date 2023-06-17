import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';

import '../../../Services/questionnaireService.dart';
import '../../../constants.dart';
import '../../../helper/constants.dart';
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
  String legend = "";

  @override
  void initState() {
    getLegend(QuestionnaireCode.assistn2.name);
    super.initState();
  }

  getLegend(questCode) {
    QuestionnaireService().getChartLegend(questCode).then((value) {
      setState(() {
        legend = value;
      });
    });
  }

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
    }
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
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Html(
                  data: legend,
                  style: {
                    "tr": Style(
                        padding: const EdgeInsets.all(2),
                        border: Border.all(color: Colors.black)),
                    "td": Style(
                      padding: const EdgeInsets.all(2),
                    ),
                  },
                  customRenders: {tableMatcher(): tableRender()},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
