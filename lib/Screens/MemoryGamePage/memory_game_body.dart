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
  List<Map<String, String>> textList = [
    {
      "name": "Autoestima",
      "description":
          "É o apreço que o indivíduo sente por ele mesmo, com base em um conjunto de valores compreendidos por ele como positivos ou negativos"
    },
    {
      "name": "Autoimagem",
      "description":
          "É a forma como o indivíduo se vê, não só fisicamente, mas emocional, social, cognitivamente e nos diversos papéis que exerce na vida"
    },
    {
      "name": "Coragem",
      "description":
          "É a capacidade do indivíduo de agir em situações desafiadoras, que causam medo ou insegurança"
    },
    {
      "name": "Compaixão",
      "description":
          "É a capacidade do indivíduo em sentir amor e interesse pelo próximo e demonstrar gentileza e disponibilidade para ajudar sempre que necessário"
    },
    {
      "name": "Tristeza",
      "description":
          "É um sentimento que se caracteriza pelo desconforto consigo mesmo ou com outras pessoas, sensação de que a vida ou o dia a dia pode ficar difícil e pesado, sensação de vazio ou falta de sentido"
    },
    {
      "name": "Empatia",
      "description":
          "É a capacidade de reconhecer ou perceber na outra pessoa características, necessidades e dores que você também teria ou sentiria"
    },
    {
      "name": "Alegria",
      "description":
          "É um sentimento de contentamento consigo, com as pessoas ou com as coisas, uma sensação de prazer e realização"
    },
    {
      "name": "Raiva",
      "description":
          "É um sentimento caracterizado por reação de fúria e agressividade contra si ou contra o outro"
    },
  ];
  List<String> randomicTextList = List<String>.filled(cardsQuantity, "");
  List<bool> blockedFlipCard = List<bool>.filled(cardsQuantity, false);
  List<double> angleCard = List<double>.filled(cardsQuantity, 0);
  List<int> selectedCardList = [];
  bool initialFlipBlock = true;
  int errorsCount = 0;

  @override
  initState() {
    super.initState();
    randomTheCards();
    Timer(Duration(seconds: 15), () => startGame());
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
        randomicTextList[randomicNumber] = textList[randomicNumber]['name']!;
        randomicTextList[randomicNumber2] =
            textList[randomicNumber]['description']!;
        i++;
      }
    }
  }

  verifyMatch(int cardIndex) {
    if (blockedFlipCard[cardIndex] == false) {
      selectedCardList.add(cardIndex);
    }
    if (selectedCardList.length == 2) {
      bool match = false;
      for (int i = 0; i < textList.length; i++) {
        if (randomicTextList[selectedCardList[0]] == textList[i]['name'] &&
            randomicTextList[selectedCardList[1]] ==
                textList[i]['description']) {
          match = true;
        } else if (randomicTextList[selectedCardList[0]] ==
                textList[i]['description'] &&
            randomicTextList[selectedCardList[1]] == textList[i]['name']) {
          match = true;
        }
      }
      if (match) {
        setState(() {
          blockedFlipCard[selectedCardList[0]] = true;
          blockedFlipCard[selectedCardList[1]] = true;
        });
      } else {
        flipWrongMatch(selectedCardList[0], selectedCardList[1]);
        setState(() {
          errorsCount++;
        });
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

  String getScore() {
    if (errorsCount == 0) {
      return "Perfeita";
    } else if (errorsCount <= 3) {
      return "Ótima";
    } else if (errorsCount <= 6 && errorsCount > 3) {
      return "Mediana";
    } else {
      return "Ruim";
    }
  }

  Widget showVictory(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Vitória!')),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.10,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Pontuação: ${getScore()}",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "Erros: $errorsCount",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.center,
                child: Text('Deseja jogar novamente?')),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
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
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("Sim"),
                  onPressed: () => goMemoryGame(context),
                ),
              ),
            ],
          ),
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
