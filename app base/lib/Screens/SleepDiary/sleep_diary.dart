import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  DateTime pickedDate;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  AnimationController controller;
  final formKey = GlobalKey<FormState>();
  TextEditingController resp1 = TextEditingController();
  TextEditingController resp2 = TextEditingController();
  TextEditingController resp3 = TextEditingController();
  TextEditingController resp5 = TextEditingController();
  TextEditingController resp6 = TextEditingController();
  TextEditingController resp7 = TextEditingController();
  TextEditingController resp8 = TextEditingController();

  String data;
  bool dataIgual = false;
  bool _loading = true;
  String _resQuest1 = "00:00";
  String _resQuest2 = "00:00";
  String _resQuest3 = "00:00";
  int qtd = 0;
  String _resQuest5 = "00:00";
  String _resQuest6 = "00:00";
  String _resQuest7 = "00:00";
  String _resQuest8 = "00:00";
  String userEmail = "00:00";

  enviarRespostas() {
    Map<String, dynamic> messageMap = {
      "resp1": _resQuest1,
      "resp2": _resQuest2,
      "resp3": _resQuest3,
      "resp4": qtd.toString(),
      "resp5": _resQuest5,
      "resp6": _resQuest6,
      "resp7": _resQuest7,
      "resp8": _resQuest8,
    };

    if (dataIgual) {
      print("Descupe, vc já respondeu hoje");
    } else {
      print("vc n respondeu hoje");
      databaseMethods.addRespostaQuestionarioSono(userEmail, messageMap, data);
      setState(() {
        dataIgual = true;
      });
    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
    pickedDate = DateTime.now();
    data = DateFormat("dd-MM-yyyy").format(pickedDate);
  }

  getUserInfo() async {
    userEmail = await HelperFunctions.getUserEmailInSharedPreference();
    databaseMethods.getDataQuestSono(userEmail).then((value) {
      value.docs.forEach((element) {
        if (element.id == data) {
          print("${element.id} é = a ${data}");
          dataIgual = true;
        }
      });
      setState(() {
        dataIgual = dataIgual;
        _loading = false;
      });
    });
  }

  Widget _buildQuest1() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            child: Text(
              "Que horas você foi para a cama?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: 100,
            child: TextFormField(
              controller: resp1,
              validator: (value) {
                if (value.isEmpty) {
                  return 'vazio';
                }
                return null;
              },
              onTap: () async {
                _resQuest1 =
                    await _selectTime(context, "Por favor, coloque o horário.");
                resp1.text = _resQuest1;
                setState(() {
                  _resQuest1 = _resQuest1;
                });
              },
              readOnly: true,
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest1 == null ? "00:00" : _resQuest1,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.access_time_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildQuest2() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            child: Text(
              "A que horas você tentou dormir?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: 100,
            child: TextFormField(
              controller: resp2,
              validator: (value) {
                if (value.isEmpty) {
                  return 'vazio';
                } else {
                  return null;
                }
              },
              onTap: () async {
                _resQuest2 =
                    await _selectTime(context, "Por favor, coloque o horário");
                resp2.text = _resQuest2;
                setState(() {
                  _resQuest2 = _resQuest2;
                });
              },
              readOnly: true,
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest2 == null ? "00:00" : _resQuest2,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.access_time_rounded),
          )
        ],
      ),
    );
  }

  Widget _buildQuest3() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            child: Text(
              "Quanto tempo você demorou para adormecer?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: 100,
            child: TextFormField(
              controller: resp3,
              validator: (value) {
                if (value.isEmpty) {
                  return 'vazio';
                }
                return null;
              },
              onTap: () async {
                _resQuest3 =
                    await _selectTime(context, "Por favor, coloque o tempo.");
                resp3.text = _resQuest3;
                setState(() {
                  _resQuest3 = _resQuest3 == null ? "00:00" : _resQuest3;
                });
              },
              readOnly: true,
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest3,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.timer),
          )
        ],
      ),
    );
  }

  Widget _buildQuest4() {
    return Container(
      height: 75,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            child: Text(
              "Quantas vezes você acordou, sem contar o seu despertar final?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (qtd > 0) {
                  qtd = qtd - 1;
                }
              });
            },
            child: Container(
              width: 50,
              child: Icon(Icons.remove),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              qtd.toString(),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                qtd = qtd + 1;
              });
            },
            child: Container(
              width: 50,
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuest5() {
    if (qtd > 0) {
      return Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              alignment: Alignment.center,
              width: 200,
              child: Text(
                "No total, quanto tempo durou esse despertar?",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                controller: resp5,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'vazio';
                  }
                  return null;
                },
                onTap: () async {
                  _resQuest5 = await _selectTime(
                      context, "Por favor, coloque o horário.");
                  resp5.text = _resQuest5;
                  setState(() {
                    _resQuest5 = _resQuest5;
                  });
                },
                readOnly: true,
                showCursor: false,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: _resQuest5 == null ? "00:00" : _resQuest5,
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: 50,
              child: Icon(Icons.timer),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildQuest6() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            child: Text(
              "A que horas foi seu despertar final?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: 100,
            child: TextFormField(
              controller: resp6,
              validator: (value) {
                if (value.isEmpty) {
                  return 'vazio';
                }
                return null;
              },
              onTap: () async {
                _resQuest6 =
                    await _selectTime(context, "Por favor, coloque o tempo.");
                resp6.text = _resQuest6;
                setState(() {
                  _resQuest6 = _resQuest6;
                });
              },
              readOnly: true,
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest6 == null ? "00:00" : _resQuest6,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.access_time_rounded),
          )
        ],
      ),
    );
  }

  Widget _buildQuest7() {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            child: Text(
              "Após seu despertar final, quanto tempo você passou na cama?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: 100,
            child: TextFormField(
              controller: resp7,
              validator: (value) {
                if (value.isEmpty) {
                  return 'vazio';
                }
                return null;
              },
              onTap: () async {
                _resQuest7 =
                    await _selectTime(context, "Por favor, coloque o tempo.");
                resp7.text = _resQuest7;
                setState(() {
                  _resQuest7 = _resQuest7;
                });
              },
              readOnly: true,
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest7 == null ? "00:00" : _resQuest7,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.timer),
          )
        ],
      ),
    );
  }

  Widget _buildQuest8() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            child: Text(
              "Quanto você dormiu durante o dia?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: 100,
            child: TextFormField(
              controller: resp8,
              validator: (value) {
                if (value.isEmpty) {
                  return 'vazio';
                }
                return null;
              },
              onTap: () async {
                _resQuest8 =
                    await _selectTime(context, "Por favor, coloque o tempo");
                resp8.text = _resQuest8;
                setState(() {
                  _resQuest8 = _resQuest8;
                });
              },
              readOnly: true,
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest8 == null ? "00:00" : _resQuest8,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.timer),
          )
        ],
      ),
    );
  }

  @override
  /* Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQuest1(),
                _buildQuest2(),
                _buildQuest3(),
                _buildQuest4(),
                _buildQuest5(),
                _buildQuest6(),
                _buildQuest7(),
                _buildQuest8(),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    'Enviar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () async {
                    print(userEmail);
                    enviarRespostas();
                    await showInformationDialog(
                        context,
                        calculoEficienciaSono(
                            _resQuest1,
                            _resQuest2,
                            _resQuest3,
                            qtd,
                            _resQuest5,
                            _resQuest6,
                            _resQuest7,
                            _resQuest8),
                        pickedDate);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dataIgual
                            ? Container(
                                height: MediaQuery.of(context).size.height,
                                alignment: Alignment.center,
                                child: Text(
                                    "Você já respondeu o questionário hoje.\n Obrigado :3",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 28,
                                    )),
                              )
                            : Column(
                                children: [
                                  _buildQuest1(),
                                  _buildQuest2(),
                                  _buildQuest3(),
                                  _buildQuest4(),
                                  _buildQuest5(),
                                  _buildQuest6(),
                                  _buildQuest7(),
                                  _buildQuest8(),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    child: Text(
                                      'Enviar',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onPressed: () async {
                                      print(userEmail);
                                      if (formKey.currentState.validate()) {
                                        enviarRespostas();
                                        await showInformationDialog(
                                            context,
                                            calculoEficienciaSono(
                                                _resQuest1,
                                                _resQuest2,
                                                _resQuest3,
                                                qtd,
                                                _resQuest5,
                                                _resQuest6,
                                                _resQuest7,
                                                _resQuest8),
                                            pickedDate);
                                      }
                                    },
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<String> _selectTime(BuildContext context, String text) async {
    final TimeOfDay result = await showTimePicker(
      context: context,
      helpText: text,
      initialTime: TimeOfDay(hour: 0, minute: 0),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child);
      },
    );

    if (result != null) {
      return DateFormat("HH:mm")
          .format(DateFormat.jm().parse(result.format(context)));
    } else {
      return null;
    }
  }
}

Future<void> showInformationDialog(
    BuildContext context, List<String> text, DateTime pickedDate) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 2.3,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 13,
                  alignment: Alignment.center,
                  child: Text(
                    "Tempo total de sono \n ${text[0]}",
                    textAlign: TextAlign.center,
                  ),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.green)),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 13,
                  alignment: Alignment.center,
                  child: Text(
                    "Tempo total na cama\n ${text[1]}",
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 13,
                  alignment: Alignment.center,
                  child: Text(
                    "Eficiência do sono\n ${text[2]}%",
                    textAlign: TextAlign.center,
                  ),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.green)),
                ),
              ],
            )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ok'),
          )
        ],
      );
    },
  );
}

calculoEficienciaSono(
    String _resQuest1,
    String _resQuest2,
    String _resQuest3,
    int qtd,
    String _resQuest5,
    String _resQuest6,
    String _resQuest7,
    String _resQuest8) {
  //<<<<<<<<<< pega quanto tempo a pessoa dormiu >>>>>>>>>>
  var format = DateFormat("HH:mm");
  var quest1 = format.parse(_resQuest1).subtract(Duration(hours: 12));
  var quest2 = format.parse(_resQuest2).subtract(Duration(hours: 12));
  var quest3 = format.parse(_resQuest3);
  var quest5 = format.parse(_resQuest5);
  var quest6 = format.parse(_resQuest6).add(Duration(hours: 12));
  var quest7 = format.parse(_resQuest7);

  var intervaloTentouDormirEAcordou =
      format.parse(quest6.difference(quest2).toString());

  var intervaloFoiParaCamaEAcordou =
      format.parse(quest6.difference(quest1).toString());

  var demorouDomirMaisTotalDespertar =
      quest3.add(Duration(hours: quest5.hour, minutes: quest5.minute));
  var tempoTotalDeSono = intervaloTentouDormirEAcordou.subtract(Duration(
    hours: demorouDomirMaisTotalDespertar.hour,
    minutes: demorouDomirMaisTotalDespertar.minute,
  ));

  var tempoTotalNaCama = intervaloFoiParaCamaEAcordou.add(Duration(
    hours: quest7.hour,
    minutes: quest7.minute,
  ));

  String tts = DateFormat("HH:mm").format(tempoTotalDeSono);
  String ttc = DateFormat("HH:mm").format(tempoTotalNaCama);

  var ttsString = tts.split(":");
  var ttcString = ttc.split(":");
  int ttsInt = int.parse(ttsString[0]) * 60 + int.parse(ttsString[1]);
  int ttcInt = int.parse(ttcString[0]) * 60 + int.parse(ttcString[1]);

  double res = ((ttsInt / ttcInt) * 100).truncateToDouble();

  List<String> res2 = [
    tts,
    ttc,
    res.toString(),
  ];

  return res2;
}
