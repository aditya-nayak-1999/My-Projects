import 'package:flutter/material.dart';
import '../models/dice.dart';
import '../models/scorecard.dart';

class Yahtzee extends StatefulWidget {
  @override
  _YahtzeeState createState() => _YahtzeeState();               // Yahtzee game widget
}

class _YahtzeeState extends State<Yahtzee> {                    // Internal state of Yahtzee game widget
  List<Dice> _dices = [];
  int _rollCount = 0;
  ScoreCard _scoreCard = ScoreCard();

  @override
  void initState() {                                            // Reset game during widget creation
    super.initState();
    _resetGame();
  }

  void _pickScore(String section) {                             // Scoring Logic
    if (!_scoreCard.isPicked(section)) {
      List<int?> diceValues = _dices.map((dice) => dice.value).toList();
      diceValues.sort();
      switch (section) {
        case 'Ones':
        case 'Twos':
        case 'Threes':
        case 'Fours':
        case 'Fives':
        case 'Sixes':
            int value = 0;
            switch (section) {
                case 'Ones':
                    value = 1;
                    break;
                case 'Twos':
                    value = 2;
                    break;
                case 'Threes':
                    value = 3;
                    break;
                case 'Fours':
                    value = 4;
                    break;
                case 'Fives':
                    value = 5;
                    break;
                case 'Sixes':
                    value = 6;
                    break;
            }
            int sum = _dices.where((dice) => dice.value == value).fold(0, (previousValue, element) => previousValue + (element.value ?? 0));
            _scoreCard.setScore(section, sum);
          break;
        case 'Three of a Kind':
          for (int i = 1; i <= 6; i++) {
            if (diceValues.where((val) => val == i).length >= 3) {
              _scoreCard.setScore(section, diceValues.fold(0, (a, b) => a + (b ?? 0)));
              break;
            } else {
              _scoreCard.setScore(section, 0);
            }
          }
          break;
        case 'Four of a Kind':
          for (int i = 1; i <= 6; i++) {
            if (diceValues.where((val) => val == i).length >= 4) {
              _scoreCard.setScore(section, diceValues.fold(0, (a, b) => a + (b ?? 0)));
              break;
            } else {
              _scoreCard.setScore(section, 0);
            }
          }
          break;
        case 'Full House':
          if (diceValues.toSet().length == 2 && (diceValues.where((val) => val == diceValues[0]).length == 2 || diceValues.where((val) => val == diceValues[0]).length == 3)) {
            _scoreCard.setScore(section, 25);
          } else {
            _scoreCard.setScore(section, 0);
          }
          break;
        case 'Small Straight':
          if (isSequential(diceValues.where((v) => v != null).toList().cast<int>(), 4)) {
            _scoreCard.setScore(section, 30);
          } else {
            _scoreCard.setScore(section, 0);
          }
          break;
        case 'Large Straight':
          if (isSequential(diceValues.where((v) => v != null).toList().cast<int>(), 5)) {
            _scoreCard.setScore(section, 40);
          } else {
            _scoreCard.setScore(section, 0);
          }
          break;
        case 'Yahtzee':
          if (_dices.where((dice) => dice.value == _dices[0].value).length == 5) {
              _scoreCard.setScore(section, 50);
          }  else {
              _scoreCard.setScore(section, 0);
            }
          break;
        case 'Chance':
          int sum = _dices.fold(0, (previousValue, element) => previousValue + (element.value ?? 0));
          _scoreCard.setScore(section, sum);
          break;
        }
      setState(() {});
      _resetRound();
      if (_scoreCard.allSectionsPicked()) {
        _checkGameOver();
      }
    }
  }

  bool isSequential(List<int> values, int sequenceLength) {        // Check if dice values contain sequential run
    for (int i = 0; i <= values.length - sequenceLength; i++) {
      int sequenceCount = 1;
      for (int j = i + 1; j < i + sequenceLength; j++) {
        if (values[j] - values[j - 1] == 1) {
          sequenceCount++;
        }
      }
      if (sequenceCount == sequenceLength) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {                            // Game UI
    return Scaffold(
      appBar: AppBar(                                             // App bar with game title
        title: Text('Yahtzee!'),
        centerTitle: true,
      ),
      body: Padding(                                              
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [                                             // Dice display and dice tapping
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _dices.map((dice) {
                return GestureDetector(
                  onTap: () {
                    if (_rollCount > 0) { 
                      setState(() {
                        dice.toggleLock();
                      });
                    }
                  },
                  child: Container(
                    width: 40,  
                    height: 40, 
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6), 
                    decoration: BoxDecoration(
                      border: Border.all(color: dice.isLocked ? Colors.red : Colors.black),
                    ),
                    child: Text(dice.value != null ? '${dice.value}' : '', style: TextStyle(fontSize: 16)),  
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 10),                                 // Roll button and roll count
            ElevatedButton(
              onPressed: _rollCount < 3 ? _rollDices : null,
              child: Text(_rollCount < 3 ? 'Roll (${_rollCount + 1})' : 'Out of Rolls!'),
              style: ElevatedButton.styleFrom(backgroundColor: _rollCount < 3 ? Colors.blue : Colors.grey),
            ),

            Expanded(                                             // Pick score for a section
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.5, 
                    ),
                    itemCount: _scoreCard.sections.length,
                    itemBuilder: (context, index) {
                        String section = _scoreCard.sections[index];
                        return ListTile(
                            title: Text(section),
                            trailing: _scoreCard.isPicked(section)
                                ? Text('${_scoreCard.getScore(section)}')
                                : TextButton(
                                    onPressed: _dices.any((dice) => dice.value == null) ? null : () => _pickScore(section),
                                    child: Text('Pick', style: TextStyle(color: _dices.any((dice) => dice.value == null) ? Colors.grey : Colors.blue)),
                                ),
                        );
                    },
                ),
            ),

            Text('Current Score: ${_scoreCard.totalScore}', style: TextStyle(fontSize: 18)),    // Current Score Display
          ],
        ),
      ),
    );
  }

  void _rollDices() {                                     // Dice rolling logic
    setState(() {
      _dices.forEach((dice) {
        if (!dice.isLocked) dice.roll();
      });
      _rollCount++;
    });
  }

  void _checkGameOver() {                                 // Display game over dialog 
    if (_scoreCard.allSectionsPicked()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over!', style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text('Your score is ${_scoreCard.totalScore}'),
            actions: [
              TextButton(
                child: Text('Play Again', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  _resetGame();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _resetGame() {                                     // Reset entire game state
    setState(() {
      _dices = List.generate(5, (index) => Dice()); 
      _dices.forEach((dice) => dice.reset());
      _scoreCard.reset();
      _rollCount = 0;
    });
  }

  void _resetRound() {                                    // Reset current round state
    setState(() {
        _dices.forEach((dice) => dice.reset());
        _rollCount = 0;
    });
  }
}
