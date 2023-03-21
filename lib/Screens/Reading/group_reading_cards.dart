import 'package:app_mental/Screens/Reading/group_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupReadingCards extends StatefulWidget {
  final List<String> groupList;

  GroupReadingCards({required this.groupList});

  @override
  State<GroupReadingCards> createState() => _GroupReadingCardsState();
}

class _GroupReadingCardsState extends State<GroupReadingCards> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        scrollDirection: Axis.vertical,
        itemCount: widget.groupList.length,
        itemBuilder: (BuildContext context, int index) {
          var group = widget.groupList.elementAt(index);
          return GroupReadingCard(
            image: "assets/images/reading01.jpg",
            title: group,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GroupListScreen(group);
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

class GroupReadingCard extends StatelessWidget {
  const GroupReadingCard({
    required this.image,
    required this.title,
    required this.press,
  });

  final String image, title;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: Text(this.title),
            ),
          ],
        ),
      ),
    );
  }
}
