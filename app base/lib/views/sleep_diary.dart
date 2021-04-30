import 'package:flutter/material.dart';

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  String _name;
  String _email;
  String _password;
  String _url;
  String _phoneNumber;
  String _calories;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'What time did you get into bed?',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'What time did you try to go to sleep?'),
      validator: (String value) {},
      onSaved: (String value) {},
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'How long did it take you to fall a sleep?'),
      validator: (String value) {},
      onSaved: (String value) {},
    );
  }

  Widget _buildUrl() {
    return TextFormField(
      decoration: InputDecoration(
          labelText:
              'How many times did you wake up, not counting your final awakening?'),
      validator: (String value) {},
      onSaved: (String value) {},
    );
  }

  Widget _buildPhonenumber() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'In total, how long did these awakening last?'),
      validator: (String value) {},
      onSaved: (String value) {},
    );
  }

  Widget _buildCalories() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'what time was your final awakening?'),
      validator: (String value) {},
      onSaved: (String value) {},
    );
  }

  Widget _buildSpendInBed() {
    return TextFormField(
      decoration: InputDecoration(
          labelText:
              'After your final awakening, how long did you spend in bed?'),
      validator: (String value) {},
      onSaved: (String value) {},
    );
  }

  Widget _buildSleepDuringTime() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'How much did you sleep during daytime?'),
      validator: (String value) {},
      onSaved: (String value) {},
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
                _buildName(),
                _buildEmail(),
                _buildPassword(),
                _buildUrl(),
                _buildPhonenumber(),
                _buildCalories(),
                _buildSpendInBed(),
                _buildSleepDuringTime(),
                SizedBox(height: 100),
                ElevatedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () => {
                    if (!_formKey.currentState.validate())
                      {}
                    else
                      {_formKey.currentState.save()}
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
