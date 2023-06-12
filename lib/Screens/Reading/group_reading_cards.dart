import 'package:app_mental/Screens/Reading/Widgets/group_reading_card.dart';
import 'package:app_mental/Screens/Reading/intervention_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/reading_rel_user_dto.dart';

class GroupReadingCardsList extends StatefulWidget {
  final List<String> readingGroupList;
  List<ReadingRelUserDTO> notificationList;
  final List<int> groupSizeList;
  final List<String> readingIconList;

  GroupReadingCardsList({
    required this.readingGroupList,
    required this.notificationList,
    required this.groupSizeList,
    required this.readingIconList,
  });

  @override
  State<GroupReadingCardsList> createState() => _GroupReadingCardsListState();
}

class _GroupReadingCardsListState extends State<GroupReadingCardsList> {
  callback(List<ReadingRelUserDTO> newNotificationList) {
    setState(() {
      widget.notificationList = newNotificationList;
    });
  }

  gotoInterventionScreen(BuildContext context, String readingGroup) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return InterventionScreen(
              readingGroup, widget.notificationList, callback);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        scrollDirection: Axis.vertical,
        itemCount: widget.readingGroupList.length,
        itemBuilder: (BuildContext context, int index) {
          String readingGroup = widget.readingGroupList.elementAt(index);
          String readingIcon = widget.readingIconList.elementAt(index);
          int groupSize = widget.groupSizeList.elementAt(index);
          return GroupReadingCard(
            notificationList: widget.notificationList,
            image: readingIcon,
            title: readingGroup,
            groupSize: groupSize,
            press: () => gotoInterventionScreen(context, readingGroup),
          );
        },
      ),
    );
  }
}
