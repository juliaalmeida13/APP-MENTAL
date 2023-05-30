import 'package:app_mental/Screens/Questionarie/Charts/SleepScreen/Widgets/time_and_text.dart';
import 'package:app_mental/Screens/Questionarie/Charts/SleepScreen/Widgets/time_and_text_final.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondCard extends StatefulWidget {
  final String tryToSleep;
  final String gotoBed;
  final String spendInBed;
  final String whileToSleep;
  final String sleepDuringDay;

  SecondCard(
      {required this.tryToSleep,
      required this.gotoBed,
      required this.spendInBed,
      required this.whileToSleep,
      required this.sleepDuringDay});

  @override
  State<SecondCard> createState() => _SecondCardState();
}

class _SecondCardState extends State<SecondCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      child: Card(
        elevation: 5,
        child: Column(children: [
          SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: FittedBox(
                child: Text(
              "Mais sobre seu sono mais recente",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            )),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TimeAndText(
                              icon: CupertinoIcons.moon,
                              time: widget.tryToSleep,
                              text: "Tentou dormir às",
                            ),
                            TimeAndText(
                              icon: Icons.access_time_outlined,
                              time: widget.gotoBed,
                              text: "Deitou-se às",
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TimeAndText(
                              icon: CupertinoIcons.cloud_sun,
                              time: widget.spendInBed,
                              text: "Tempo de cama após o despertar final",
                            ),
                            TimeAndText(
                              icon: CupertinoIcons.zzz,
                              time: widget.whileToSleep,
                              text: "Tempo para adormecer",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TimeAndTextFinal(
                    icon: CupertinoIcons.zzz,
                    time: widget.sleepDuringDay,
                    text: "Sono durante o dia",
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
