import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class RowCalendar extends StatelessWidget {
  const RowCalendar({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DayCard(
          key: UniqueKey(),
            day: 01,
            month: "Julho",
            press: () {
              /*Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsScreen())); */
            }),
      ],
    );
  }
}

class DayCard extends StatelessWidget {
  const DayCard({
    required Key key,
    required this.press,
    required this.day,
    required this.month,
  }) : super(key: key);
  final int day;
  final String month;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding, horizontal: kDefaultPadding *2),
      child: GestureDetector(
        onTap: press,
        child: Row(
          children: <Widget>[
            Container(
              height: 100,
              width: 60,
              decoration:BoxDecoration(
                  color: kBackgroundGrey,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow:[BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryGreen.withOpacity(0.23)
                  )]
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "\n$day\n".toUpperCase(),
                      style: TextStyle(
                        color: kSecondaryRed.withOpacity(0.85),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "$month".toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                height:100,
                width:200,
                decoration: BoxDecoration(
                    color: kBackgroundLightGreen,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [BoxShadow(offset: Offset(0, 10), blurRadius: 50,color: kPrimaryGreen.withOpacity(0.23))]
                )
            ),
          ],
        ),
      ),
    );
  }
}
