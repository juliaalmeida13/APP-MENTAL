import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class NewContact extends StatefulWidget {
  final Function addCt;

  NewContact(this.addCt);

  @override
  _NewContactState createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  void submitData() {
    final enteredName = nameController.text;
    final enteredNumber = numberController.text;

    if (enteredName.isEmpty || enteredNumber.length < 8) {
      return;
    }

    widget.addCt(
      enteredName,
      enteredNumber,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Apelido'),
              controller: nameController,
              onSubmitted: (_) => submitData(),
              /*onChanged: (value) {
                      titleInput = value;
                    },*/
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Número'),
              controller: numberController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              /*onChanged: (value) => amountInput = value,  
                    },*/
            ),
            FlatButton(
              child: Text('Adicionar contato'),
              textColor: Color(0xFF21BFBD),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
