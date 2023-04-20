import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CheckboxContact extends StatefulWidget {
  final Contact contact;
  final bool checkedValue;
  final int phoneContactListIndex;
  final Function checkboxHandler;

  CheckboxContact(this.contact, this.checkedValue, this.phoneContactListIndex,
      this.checkboxHandler);

  @override
  _CheckboxContactState createState() => _CheckboxContactState();
}

class _CheckboxContactState extends State<CheckboxContact> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.checkedValue,
      activeColor: Colors.green,
      side: BorderSide(color: AppColors.green),
      onChanged: (newValue) =>
          widget.checkboxHandler(newValue, widget.phoneContactListIndex),
      title: Text(widget.contact.displayName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.contact.phones.isNotEmpty
              ? Text(widget.contact.phones[0].number)
              : Text("Sem número"),
        ],
      ),
    );
  }
}
