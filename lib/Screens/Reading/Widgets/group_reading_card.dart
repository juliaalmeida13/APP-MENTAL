import 'package:flutter/material.dart';

import '../../../model/reading_rel_user_dto.dart';

class GroupReadingCard extends StatefulWidget {
  const GroupReadingCard(
      {required this.image,
      required this.title,
      required this.press,
      required this.notificationList});

  final String image, title;
  final Function() press;
  final List<ReadingRelUserDTO> notificationList;

  @override
  State<GroupReadingCard> createState() => _GroupReadingCardState();
}

class _GroupReadingCardState extends State<GroupReadingCard> {
  Widget _notification() {
    bool notificationStatus = false;
    widget.notificationList.forEach((element) {
      if (element.group == this.widget.title) {
        notificationStatus = true;
      }
    });
    return (notificationStatus == true)
        ? Container(
            width: 20,
            height: 20,
            decoration: new BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: ListTile(
                      title: Text(this.widget.title),
                    ),
                  ),
                  Container(
                      alignment: Alignment.topRight, child: _notification()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
