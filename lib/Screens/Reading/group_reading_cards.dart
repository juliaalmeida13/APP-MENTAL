import 'package:app_mental/Screens/Reading/Widgets/group_reading_card.dart';
import 'package:app_mental/Screens/Reading/intervention_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/reading_rel_user_dto.dart';

class GroupReadingCardsList extends StatefulWidget {
  final List<String> readingGroupList;
  List<ReadingRelUserDTO> notificationList;

  GroupReadingCardsList(
      {required this.readingGroupList, required this.notificationList});

  @override
  State<GroupReadingCardsList> createState() => _GroupReadingCardsListState();
}

class _GroupReadingCardsListState extends State<GroupReadingCardsList> {
  callback(List<ReadingRelUserDTO> newNotificationList) {
    setState(() {
      widget.notificationList = newNotificationList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        scrollDirection: Axis.vertical,
        itemCount: widget.readingGroupList.length,
        itemBuilder: (BuildContext context, int index) {
          var readingGroup = widget.readingGroupList.elementAt(index);
          return GroupReadingCard(
            notificationList: widget.notificationList,
            image: "assets/images/reading01.jpg",
            title: readingGroup,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InterventionScreen(
                        readingGroup, widget.notificationList, callback);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
