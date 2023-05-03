import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DeckCard extends StatefulWidget {
  final String title;
  final double angleCard;
  final int indexCard;
  final Function flipCard;

  DeckCard(
      {required this.title,
      required this.angleCard,
      required this.indexCard,
      required this.flipCard});

  @override
  State<DeckCard> createState() => _DeckCardState();
}

class _DeckCardState extends State<DeckCard> {
  bool isBack = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.flipCard(widget.indexCard),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: widget.angleCard),
        duration: Duration(milliseconds: 500),
        builder: (BuildContext context, double val, _) {
          if (val >= (pi / 2)) {
            isBack = true;
          } else {
            isBack = false;
          }
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(val),
            child: Container(
              width: MediaQuery.of(context).size.height * 0.10,
              height: MediaQuery.of(context).size.width * 0.3,
              child: isBack
                  ? Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/back-card.jpeg"),
                        ),
                      ),
                    )
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(2 * pi),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Center(
                            child: AutoSizeText(widget.title,
                                minFontSize: 2, textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
