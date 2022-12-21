import 'dart:math';

import 'package:flutter/material.dart';

class BlackJackScreen extends StatefulWidget {
  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool isGameStarted = false;

  List<Image> myCards = [];
  List<Image> dealersCards = [];

  String? playersFirstCards;
  String? playersSecondCards;

  String? dealersFirstCards;
  String? dealersSecondCards;

  int playersScore = 0;
  int dealersScore = 0;

  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };

  Map<String, int> playingCards = {};

  @override
  void initState() {
    super.initState();
    playingCards.addAll(deckOfCards);
  }

  void changeCards() {
    setState(() {
      isGameStarted = true;
    });
    // метод для перемештвагия колоды
    playingCards = {};

    playingCards.addAll(deckOfCards);
    //  логика для создания нового раунда
    //  карт в рукух игрока и дилера не будет
    myCards = [];
    dealersCards = [];
    // раздадим рандомные карты игроку и дилеру
    Random random = Random();
    // задаем рандомное число. добавляем наши карты

    //находим рандомную карту номер 1
    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    // карты не должны повторятся,будем их сразу уберать
    playingCards.removeWhere((key, value) => key == cardOneKey);

    //Создание метода для вторй карты
    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);
    // создаем еще два метода т к у игрока и дилера по две карты
    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardFourKey);

    //раздаем карты
    dealersFirstCards = cardOneKey;
    dealersSecondCards = cardTwoKey;

    playersFirstCards = cardThreeKey;
    playersSecondCards = cardFourKey;
    // Добавляем картинки

    dealersCards.add(Image.asset(dealersFirstCards!)); // не можнт быть null
    dealersCards.add(Image.asset(dealersSecondCards!));
    // подсчет очков.  обозначаем что точно не null
    dealersScore =
        deckOfCards[dealersFirstCards]! + deckOfCards[dealersSecondCards]!;
    // добавим карты
    myCards.add(Image.asset(playersFirstCards!));
    myCards.add(Image.asset(playersSecondCards!));
    // подчтитаем наши очки

    playersScore =
        deckOfCards[playersFirstCards]! + deckOfCards[playersSecondCards]!;

    // дилер должен брать карты если очков меньше 14
    if(dealersScore <= 14) {
      String thirdDealersCardKey = playingCards.keys.elementAt(random.nextInt(playingCards.length));
      // убеоем эту карту из колоды
      playingCards.removeWhere((key, value) => key == thirdDealersCardKey);

      dealersCards.add(Image.asset(thirdDealersCardKey));
      // поменяем количество очков
      dealersScore = dealersScore + deckOfCards[thirdDealersCardKey]!;
    }
  }

  void addCard() {
    Random random = Random();
    if (playingCards.length > 0 ) {
      //создаем рандом
      String cardKey =
      playingCards.keys.elementAt(random.nextInt(playingCards.length));
      // убераем карту из колоды
      playingCards.removeWhere((key, value) => key == cardKey);
      // добавляем карту
      setState(() {
        myCards.add(Image.asset(cardKey));
      });
      // поменяем значение очков
      playersScore = playersScore + deckOfCards[cardKey]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isGameStarted
          ? SafeArea(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Dealers Cards
                  Column(
                    children: [
                      Text('Dealer score $dealersScore',style: TextStyle(
                        // цвет будет зависеть от количества очков

                        color: dealersScore <= 21 ? Colors.green[900] : Colors.red[900]
                      ),),
                      SizedBox(height: 20),
                      // Grid View
                      Container(
                        height: 200,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: dealersCards.length,
                            //нужно указать сколько будет items
                            physics: NeverScrollableScrollPhysics(),
                            // Для того что бы GridView не скролил
                            itemBuilder: (context, index) {
                              //возвращаем виджет
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: dealersCards[index],
                              );
                            }),
                      ),
                    ],
                  ),

                  //players Cards
                  Column(
                    children: [
                      Text('Player score $playersScore',style: TextStyle(
                        color: playersScore <= 21 ? Colors.green[900] : Colors.red[900]
                      ),),
                      SizedBox(height: 20),
                      Container(
                        height: 200,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: myCards.length,
                            //нужно указать сколько будет items
                          //  physics: NeverScrollableScrollPhysics(), // Для того что бы GridView не скролил

                            itemBuilder: (context, index) {
                              //возвращаем виджет
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: myCards[index],
                              );
                            }),
                      ),
                    ],
                  ),

                  // Button
                  IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MaterialButton(
                          onPressed: addCard,
                          child: Text('Another Card'),
                          color: Colors.brown[200],
                        ),
                        MaterialButton(
                          onPressed:  changeCards,
                          child: Text('Next Round '),
                          color: Colors.brown[200],

                        ),
                      ],
                    ),
                  )
                ],
              )),
            )
          : Center(
              child: MaterialButton(
                onPressed: changeCards,

                color: Colors.brown[200],
                child: Text('Start Game'),
              ),
            ),
    );
  }
}
