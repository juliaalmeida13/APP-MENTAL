import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/reading_rel_user_dto.dart';

class GroupReadingCard extends StatefulWidget {
  const GroupReadingCard(
      {required this.image,
      required this.title,
      required this.press,
      required this.notificationList,
      required this.groupSize});

  final String image, title;
  final Function() press;
  final List<ReadingRelUserDTO> notificationList;
  final int groupSize;

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
        child: Container(
          width: double.infinity,
          height: 80,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child:
                    Container(child: Image.memory(base64Decode(widget.image))),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.groupSize.toString()} materiais disponíveis",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                        alignment: Alignment.topRight, child: _notification()),
                    Container(
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_forward_ios)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
