import 'package:app_mental/Screens/InterventionListing/Widgets/body.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class GroupListScreen extends StatelessWidget {
  GroupListScreen(this.group);

  final String group;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      body: Body(group),
    );
  }
}
