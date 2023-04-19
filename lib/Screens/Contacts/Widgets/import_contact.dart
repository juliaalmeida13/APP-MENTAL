import 'package:app_mental/Services/contactService.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../helper/helperfuncions.dart';
import 'checkbox_contact.dart';

class ImportContact extends StatefulWidget {
  final Function searchContacts;
  final List<Contact> phoneContactList;

  ImportContact(this.searchContacts, this.phoneContactList);

  @override
  _ImportContactState createState() => _ImportContactState();
}

class _ImportContactState extends State<ImportContact> {
  List<bool> checkedValue = [];

  changeCheckboxValue(newValue, index) {
    setState(() {
      checkedValue[index] = newValue!;
    });
  }

  _saveSelectedContact() async {
    List<Map<String, String>> listContact = [];
    for (int i = 0; i < checkedValue.length; i++) {
      if (checkedValue[i] == true) {
        listContact.add({
          "name": widget.phoneContactList[i].displayName,
          "phone": widget.phoneContactList[i].phones.isNotEmpty
              ? widget.phoneContactList[i].phones[0].number
              : ""
        });
      }
    }
    if (listContact.isNotEmpty) {
      ContactService()
          .savePhoneContacts(
              await HelperFunctions.getUserEmailInSharedPreference(),
              listContact)
          .then((_) {
        widget.searchContacts();
        Navigator.pop(context);
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Escolha os contatos para importar:"),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => _saveSelectedContact(),
              child: const Text('Importar contatos'),
            ),
          ],
        ),
      ],
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView.builder(
          //key: UniqueKey(),
          itemCount: widget.phoneContactList.length,
          itemBuilder: (context, index) {
            Contact contact = widget.phoneContactList[index];
            checkedValue.add(false);
            return Card(
              child: Column(
                children: [
                  CheckboxContact(
                      contact, checkedValue[index], index, changeCheckboxValue),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
