import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  DateTime pickedDate;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  String _resQuest1;
  String _resQuest2;
  String _resQuest3;
  int qtd = 0;
  String _resQuest5;
  String _resQuest6;
  String _resQuest7;
  String _resQuest8;
  String userEmail;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    databaseMethods.addRespostaQuestionarioSono(userEmail, messageMap);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
    pickedDate = DateTime.now();
  }

  getUserInfo() async {
    userEmail = await HelperFunctions.getUserEmailInSharedPreference();
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
              onTap: () async {
                _resQuest1 =
                    await _selectTime(context, "Por favor, coloque o horário.");
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
              onTap: () async {
                _resQuest2 =
                    await _selectTime(context, "Por favor, coloque o horário");
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
              onTap: () async {
                _resQuest3 =
                    await _selectTime(context, "Por favor, coloque o tempo.");
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
                onTap: () async {
                  _resQuest5 = await _selectTime(
                      context, "Por favor, coloque o horário.");
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
              onTap: () async {
                _resQuest6 =
                    await _selectTime(context, "Por favor, coloque o tempo.");
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
              onTap: () async {
                _resQuest7 =
                    await _selectTime(context, "Por favor, coloque o tempo.");
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
              onTap: () async {
                _resQuest8 =
                    await _selectTime(context, "Por favor, coloque o tempo");
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
  Widget build(BuildContext context) {
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
                  onPressed: () => {print(userEmail), enviarRespostas()},
                ),
              ],
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
      initialTime: TimeOfDay.now(),
      ,
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
