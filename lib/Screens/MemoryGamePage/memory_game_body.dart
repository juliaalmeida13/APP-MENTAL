import 'dart:async';
import 'dart:math';

import 'package:app_mental/Screens/MemoryGamePage/Widget/deck_card.dart';
import 'package:flutter/material.dart';

class MemoryGameBody extends StatefulWidget {
  @override
  State<MemoryGameBody> createState() => _MemoryGameBodyState();
}

class _MemoryGameBodyState extends State<MemoryGameBody> {
  static final int cardsQuantity = 8;
  List<String> textList = [
    "Lorem ipsum dolor sit amet. Est voluptatem soluta",
    "Excepturi quibusdam et cupiditate cupiditate sit debitis",
    "At eveniet voluptate et beatae",
    "Et voluptatum voluptas ut deserunt nihil",
    "Ut omnis doloribus non alias praesentium et eaque",
    "quibusdam in odio nisi",
    "Quis ipsam vel doloremque impedit qui enim fugit",
    "Aut consequuntur tempore ab consequatur facere sit facilis"
  ];
  List<String> randomicTextList = List<String>.filled(cardsQuantity, "");
  List<bool> blockedFlipCard = List<bool>.filled(cardsQuantity, false);
  List<double> angleCard = List<double>.filled(cardsQuantity, 0);
  List<int> selectedCardList = [];
  bool initialFlipBlock = true;

  @override
  initState() {
    super.initState();
    randomTheCards();
    Timer(Duration(seconds: 10), () => startGame());
  }

  startGame() {
    for (int i = 0; i < cardsQuantity; i++)
      setState(() {
        angleCard[i] = pi % (2 * pi);
      });
    setState(() {
      initialFlipBlock = false;
    });
  }

  randomTheCards() {
    for (int i = 0; i < cardsQuantity / 2;) {
      int randomicNumber = Random().nextInt(textList.length);
      int randomicNumber2 = Random().nextInt(textList.length);
      if (!randomicTextList.contains(textList[randomicNumber]) &&
          randomicNumber2 != randomicNumber &&
          randomicTextList[randomicNumber2] == "" &&
          randomicTextList[randomicNumber] == "") {
        randomicTextList[randomicNumber] = textList[randomicNumber];
        randomicTextList[randomicNumber2] = textList[randomicNumber];
        i++;
      }
    }
  }

  verifyMatch(int cardIndex) {
    if (blockedFlipCard[cardIndex] == false) {
      selectedCardList.add(cardIndex);
    }
    if (selectedCardList.length == 2) {
      if (randomicTextList[selectedCardList[0]] ==
              randomicTextList[selectedCardList[1]] &&
          selectedCardList[0] != selectedCardList[1]) {
        setState(() {
          blockedFlipCard[selectedCardList[0]] = true;
          blockedFlipCard[selectedCardList[1]] = true;
        });
      } else {
        flipWrongMatch(selectedCardList[0], selectedCardList[1]);
      }
      selectedCardList.clear();
    }
    if (!blockedFlipCard.contains(false)) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => showVictory(context),
      );
    }
  }

  goHomePage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/logged-home");
  }

  goMemoryGame(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/memory_game_screen");
  }

  Widget showVictory(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Vitória!')),
      content: Text('Deseja jogar novamente?'),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Não"),
                onPressed: () => goHomePage(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Sim"),
                onPressed: () => goMemoryGame(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  flipCard(int cardIndex) {
    if (!blockedFlipCard[cardIndex] && !initialFlipBlock) {
      setState(() {
        angleCard[cardIndex] = (angleCard[cardIndex] + pi) % (2 * pi);
      });
      Timer(Duration(seconds: 3), () {
        verifyMatch(cardIndex);
      });
    }
  }

  flipWrongMatch(int cardIndex1, int cardIndex2) {
    setState(() {
      angleCard[cardIndex1] = (angleCard[cardIndex1] + pi) % (2 * pi);
      angleCard[cardIndex2] = (angleCard[cardIndex2] + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 3,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < cardsQuantity ~/ 4; i++) ...[
                  DeckCard(
                      title: randomicTextList[i],
                      angleCard: angleCard[i],
                      indexCard: i,
                      flipCard: flipCard),
                ],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = cardsQuantity ~/ 4;
                    i < cardsQuantity ~/ 2;
                    i++) ...[
                  DeckCard(
                      title: randomicTextList[i],
                      angleCard: angleCard[i],
                      indexCard: i,
                      flipCard: flipCard),
                ],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = cardsQuantity ~/ 2;
                    i < (cardsQuantity * 3) ~/ 4;
                    i++) ...[
                  DeckCard(
                      title: randomicTextList[i],
                      angleCard: angleCard[i],
                      indexCard: i,
                      flipCard: flipCard),
                ],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = (cardsQuantity * 3) ~/ 4;
                    i < cardsQuantity;
                    i++) ...[
                  DeckCard(
                      title: randomicTextList[i],
                      angleCard: angleCard[i],
                      indexCard: i,
                      flipCard: flipCard),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
