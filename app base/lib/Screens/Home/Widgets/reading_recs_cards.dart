import 'package:chat_app_tutorial/Screens/Reading/reading_screen.dart';
import 'package:chat_app_tutorial/Screens/Video/video_interv_screen.dart';
import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecomendsReadings extends StatelessWidget {
  const RecomendsReadings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.95,
        ),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ReadingRecomendCard(
            image: "assets/images/gardening02.jpg",
            title: "Lazer",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReadingScreen()));
            },
          ),
          ReadingRecomendCard(
            image: "assets/images/sleep01.jpg",
            title: "Sono",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VideoScreen()));
            },
          ),
          ReadingRecomendCard(
            image: "assets/images/stress01.jpg",
            title: "Estresse",
            press: () {},
          ),
          ReadingRecomendCard(
            image: "assets/images/jogging01.jpg",
            title: "Exercícios",
            press: () {},
          ),
          ReadingRecomendCard(
            image: "assets/images/happy02.jpg",
            title: "Felicidade",
            press: () {},
          ),
          ReadingRecomendCard(
            image: "assets/images/habits.jpg",
            title: "Rotina",
            press: () {},
          ),
          ReadingRecomendCard(
            image: "assets/images/mentalhealth01.jpg",
            title: "PICS",
            press: () {},
          ),
          ReadingRecomendCard(
            image: "assets/images/care01.jpg",
            title: "Redução Danos",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class ReadingRecomendCard extends StatelessWidget {
  const ReadingRecomendCard({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding * 0.6),
      child: Column(
        children: <Widget>[
          Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(image),
                  ))),
          GestureDetector(
            onTap: press,
            child: Container(
              width: 100,
              height: 25,
              //margin: EdgeInsets.all(kDefaultPadding / 4),
              //padding: EdgeInsets.all(kDefaultPadding / 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kBackgroundGrey.withOpacity(0.23),
                    ),
                  ]),
              child: Text(
                "$title\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
