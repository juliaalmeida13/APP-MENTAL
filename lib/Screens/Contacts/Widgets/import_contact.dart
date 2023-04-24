import 'package:app_mental/Services/contactService.dart';
import 'package:fast_contacts/fast_contacts.dart' as fastContact;
import 'package:flutter/material.dart';

import '../../../model/contact.dart';
import '../../../helper/helperfuncions.dart';
import 'checkbox_contact.dart';

class ImportContact extends StatefulWidget {
  final Function searchContacts;
  final List<fastContact.Contact> phoneContactList;

  ImportContact(this.searchContacts, this.phoneContactList);

  @override
  _ImportContactState createState() => _ImportContactState();
}

class _ImportContactState extends State<ImportContact> {
  List<bool> isCheckedList = [];

  changeCheckboxValue(newValue, index) {
    setState(() {
      isCheckedList[index] = newValue!;
    });
  }

  _saveSelectedContact() async {
    List<Contact> listContact = [];
    for (int i = 0; i < isCheckedList.length; i++) {
      if (isCheckedList[i] == true) {
        listContact.add(Contact(
            id: i,
            name: widget.phoneContactList[i].displayName,
            number: widget.phoneContactList[i].phones.isNotEmpty
                ? widget.phoneContactList[i].phones[0].number
                : ""));
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
          itemCount: widget.phoneContactList.length,
          itemBuilder: (context, index) {
            fastContact.Contact contact = widget.phoneContactList[index];
            isCheckedList.add(false);
            return Card(
              child: Column(
                children: [
                  CheckboxContact(contact, isCheckedList[index], index,
                      changeCheckboxValue),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
