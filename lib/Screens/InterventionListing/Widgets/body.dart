import 'dart:ui';

import 'package:app_mental/Screens/Reading/reading_screen.dart';
import 'package:app_mental/Screens/Video/video_interv_screen.dart';
import 'package:app_mental/Services/interventions.dart';
import 'package:app_mental/classes/Intervention.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body(this.group);

  final String group;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          ///titulo da pagina

          Expanded(
              child: Stack(children: <Widget>[
            ///Background
            Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  color: AppColors.cinzamedio,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                )),
            ListView.builder(
                itemCount:
                    Interventions().getInterventionsByCategory(group)!.length,
                itemBuilder: (context, index) {
                  final Intervention intervention =
                      Interventions().getInterventionsByCategory(group)![index];
                  return IntervCard(intervention: intervention);
                }),
          ]))
        ],
      ),
    );
  }
}

class IntervCard extends StatelessWidget {
  final Intervention intervention;

  const IntervCard({
    Key? key,
    required this.intervention,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return this.intervention.tipo != "video"
                    ? ReadingScreen(
                        intervention.nome,
                        intervention.arquivo,
                        intervention.imagem,
                        intervention.id,
                      )
                    : VideoScreen(intervention.nome, intervention.arquivo,
                        intervention.video, intervention.id);
              },
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          //color: kSecondaryGreen,
          height: 120,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ///background cards
              Container(
                height: 106,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: kBackgroundLightGreen,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 15),
                        blurRadius: 27,
                        color: Colors.black12)
                  ],
                ),
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    )),
              ),

              ///illustrative image
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    height: 106,
                    width: 116,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                            image: AssetImage('assets/images/reading01.jpg'),
                            width: size.width,
                            fit: BoxFit.cover))),
              ),

              ///title
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    height: 106,

                    ///our image take 116 width, so we set our total width -116
                    width: size.width - 116,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Spacer(),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: Text(intervention.nome,
                                style: AppTextStyles.heading)),
                        Spacer(),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
