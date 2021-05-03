import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/services/database.dart';
import 'package:flutter/material.dart';

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {

  DatabaseMethods databaseMethods = new DatabaseMethods();

  String _resQuest1 = '00:00';
  String _resQuest2 = '00:00';
  String _resQuest3 = '00:00';
  String _resQuest4 = '00:00';
  String _resQuest5 = '00:00';
  String _resQuest6 = '00:00';
  String _resQuest7 = '00:00';
  String _resQuest8 = '00:00';
  String userEmail;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  enviarRespostas() {
      Map<String, dynamic> messageMap = {
        "resp1": _resQuest1,
        "resp2": _resQuest2,
        "resp3": _resQuest3,
        "resp4": _resQuest4,
        "resp5": _resQuest5,
        "resp6": _resQuest6,
        "resp7": _resQuest7,
        "resp8": _resQuest8,
      };
      databaseMethods.addRespostaQuestionarioSono( userEmail, messageMap);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
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
            child: Text("Que horas você foi para a cama?", style: TextStyle(
              fontSize: 16
            ),),
          ),
          Container(
              width: 100,
              child: TextFormField(
                onTap: () async{
                  _resQuest1 = await _selectTime(context);
                  setState(() {
                    _resQuest1 = _resQuest1;
                  });
                },
                showCursor: false,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: _resQuest1,
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          Container(
              width: 50,
              child: Icon(Icons.alarm),
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
            child: Text("A que horas você tentou dormir?", style: TextStyle(
                fontSize: 16
            ),),
          ),
          Container(
            width: 100,
            child: TextFormField(
              onTap: () async{
                _resQuest2 = await _selectTime(context);
                setState(() {
                  _resQuest2 = _resQuest2;
                });
              },
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest2,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.alarm),
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
            child: Text("Quanto tempo você demorou para adormecer?", style: TextStyle(
                fontSize: 16
            ),),
          ),
          Container(
            width: 100,
            child: TextFormField(
              onTap: () async{
                _resQuest3 = await _selectTime(context);
                setState(() {
                  _resQuest3 = _resQuest3;
                });
              },
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
            child: Icon(Icons.alarm),
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
            child: Text("Quantas vezes você acordou, sem contar o seu despertar final?", style: TextStyle(
                fontSize: 16
            ),),
          ),
          Container(
            width: 100,
            child: TextFormField(
              onTap: () async{
                _resQuest4 = await _selectTime(context);
                setState(() {
                  _resQuest4 = _resQuest4;
                });
              },
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest4,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.alarm),
          )
        ],
      ),
    );
  }

  Widget _buildQuest5() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            child: Text("No total, quanto tempo durou esse despertar?", style: TextStyle(
                fontSize: 16
            ),),
          ),
          Container(
            width: 100,
            child: TextFormField(
              onTap: () async{
                _resQuest5 = await _selectTime(context);
                setState(() {
                  _resQuest5 = _resQuest5;
                });
              },
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest5,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.alarm),
          )
        ],
      ),
    );
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
            child: Text("A que horas foi seu despertar final?", style: TextStyle(
                fontSize: 16
            ),),
          ),
          Container(
            width: 100,
            child: TextFormField(
              onTap: () async{
                _resQuest6 = await _selectTime(context);
                setState(() {
                  _resQuest6 = _resQuest6;
                });
              },
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest6,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.alarm),
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
            child: Text("Após seu despertar final, quanto tempo você passou na cama?", style: TextStyle(
                fontSize: 16
            ),),
          ),
          Container(
            width: 100,
            child: TextFormField(
              onTap: () async{
                _resQuest7 = await _selectTime(context);
                setState(() {
                  _resQuest7 = _resQuest7;
                });
              },
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest7,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.alarm),
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
            child: Text("Quanto você dormiu durante o dia?", style: TextStyle(
                fontSize: 16
            ),),
          ),
          Container(
            width: 100,
            child: TextFormField(
              onTap: () async{
                _resQuest8 = await _selectTime(context);
                setState(() {
                  _resQuest8 = _resQuest8;
                });
              },
              showCursor: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: _resQuest8,
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            child: Icon(Icons.alarm),
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
                  onPressed: () => {
                    print(userEmail),
                    enviarRespostas()
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _selectTime( BuildContext context) async{
    final TimeOfDay result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ), child: child);
        },
    );

    if(result !=null){
        return result.format(context);
    }else{
      return null;
    }
  }
}
