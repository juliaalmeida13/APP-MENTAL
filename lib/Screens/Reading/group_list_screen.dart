import 'package:app_mental/Screens/Reading/Widgets/group_body.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class GroupListScreen extends StatelessWidget {
  final String group;

  GroupListScreen(this.group);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryGreen,
      appBar: AppBar(
          backgroundColor: kTextColorGreen,
          shadowColor: Colors.transparent,
          leading: BackButton(
            color: Colors.white,
            onPressed: () => {Navigator.pop(context)},
          ),
          title: FittedBox(child: Text(group))),
      body: GroupBody(group),
    );
  }
}
