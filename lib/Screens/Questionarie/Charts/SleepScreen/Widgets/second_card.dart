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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.moon,
                                      color: Colors.blue,
                                    ),
                                    Column(
                                      children: [
                                        FittedBox(
                                            child: Text(
                                                "${widget.tryToSleep} AM",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20))),
                                        FittedBox(
                                            child: Text("Tentou dormir às")),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      color: Colors.blue,
                                    ),
                                    Column(
                                      children: [
                                        FittedBox(
                                            child: Text("${widget.gotoBed} PM",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20))),
                                        FittedBox(child: Text("Deitou-se às")),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                                "${widget.spendInBed} min",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20)),
                                          ),
                                          AutoSizeText(
                                              "Tempo de cama após o despertar final"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.zzz,
                                      color: Colors.blue,
                                    ),
                                    Column(
                                      children: [
                                        FittedBox(
                                          child: Text(
                                              "${widget.whileToSleep} min",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20)),
                                        ),
                                        FittedBox(
                                            child:
                                                Text("Tempo para adormecer")),
                                      ],
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
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.zzz,
                                color: Colors.blue,
                              ),
                              Column(
                                children: [
                                  FittedBox(
                                    child: Text("${widget.sleepDuringDay} min",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 22)),
                                  ),
                                  FittedBox(child: Text("Sono durante o dia")),
                                ],
                              ),
                            ]),
                      ],
                    ),
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
