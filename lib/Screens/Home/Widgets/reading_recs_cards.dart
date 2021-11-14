import 'dart:ui';

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
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
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
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,

        //personalização do card
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: ListTile(
            tileColor: AppColors.verdeclaro,
            title: Row(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / (2.5),
                    child: Text(
                      this.title,
                      style: AppTextStyles.homecard,
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width / (2.3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/controle.png')))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
