import 'package:app_mental/Screens/InterventionListing/intervention_list.dart';
import 'package:app_mental/Services/interventions.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecomendsReadings extends StatelessWidget {
  const RecomendsReadings();

  @override
  Widget build(BuildContext context) {
    print(Interventions().getInterventions());
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.95,
        ),
        scrollDirection: Axis.vertical,
        itemCount: Interventions().getCategories().length,
        itemBuilder: (BuildContext context, int index) {
          final item = Interventions().getCategories()[index];

          return ReadingRecomendCard(
            image: "assets/images/reading01.jpg",
            title: item.nome,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GroupListScreen(item.nome);
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
