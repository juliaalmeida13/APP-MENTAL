import 'package:app_mental/Screens/Reading/intervention_list.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

import '../../model/reading_rel_user_dto.dart';

class InterventionScreen extends StatelessWidget {
  final String readingGroup;
  final List<ReadingRelUserDTO> notificationList;
  final Function callback;

  InterventionScreen(this.readingGroup, this.notificationList, this.callback);

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
          title: FittedBox(child: Text(readingGroup))),
      body: InterventionList(readingGroup, notificationList, callback),
    );
  }
}
