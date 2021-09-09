import 'package:app_mental/Screens/Reading/reading_screen.dart';
import 'package:app_mental/Screens/Video/video_interv_screen.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecomendsReadings extends StatelessWidget {
  const RecomendsReadings();

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
            image: "assets/images/reading01.jpg",
            title: "Lazer",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadingScreen(
                          "Lazer",
                          "assets/text/Leisure/leisure01.md",
                          "assets/images/reading01.jpg",
                          "lazer01")));
            },
          ),
          ReadingRecomendCard(
            image: "assets/images/sleep01.jpg",
            title: "Sono",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadingScreen(
                          "Sono",
                          "assets/text/Sleep/sleep03.md",
                          "assets/images/sleep01.jpg",
                          "sono03")));
            },
          ),
          ReadingRecomendCard(
            image: "assets/images/stress01.jpg",
            title: "Estresse",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadingScreen(
                          "Manejo Estresse",
                          "assets/text/StressMgt/stress01.md",
                          "assets/images/stress01.jpg",
                          "stress01")));
            },
          ),
          ReadingRecomendCard(
            image: "assets/images/jogging01.jpg",
            title: "Exercícios",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadingScreen(
                          "Atividade Física",
                          "assets/text/Exercise/exercise01.md",
                          "assets/images/jogging01.jpg",
                          "exercise01")));
            },
          ),
          ReadingRecomendCard(
            image: "assets/images/happy02.jpg",
            title: "Felicidade",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadingScreen(
                          "Felicidade",
                          "assets/text/Happiness/hapiness01.md",
                          "assets/images/happy02.jpg",
                          "happines01")));
            },
          ),
          ReadingRecomendCard(
            image: "assets/images/habits.jpg",
            title: "Rotina",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadingScreen(
                          "Rotina",
                          "assets/text/DailyLifeHabits/dailylife01.md",
                          "assets/images/cooking01.jpg",
                          "rotina01")));
            },
          ),
          ReadingRecomendCard(
            image: "assets/images/mentalhealth01.jpg",
            title: "PICS",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoScreen("Yoga",
                          "assets/text/PICS/pics01.md", "mnfZ3UmaydM")));
            },
          ),
          ReadingRecomendCard(
            image: "assets/images/care01.jpg",
            title: "Redução Danos",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadingScreen(
                          "Alcóol",
                          "assets/text/DamageControl/damage_control02.md",
                          "assets/images/touch01.jpg",
                          "reduce02")));
            },
          ),
        ],
      ),
    );
  }
}

class ReadingRecomendCard extends StatelessWidget {
  const ReadingRecomendCard({
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
      child: Row(children: [
        Expanded(
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
              Container(
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
            ],
          ),
        )
      ]),
    );
  }
}
