import 'package:flutter/material.dart';
import 'dart:math';
import '../models/flashcard.dart';
import '../utils/db_helper.dart';

class FlashcardQuiz extends StatefulWidget {
  static const routeName = '/flashcard-quiz';
  final String deckId;

  FlashcardQuiz({required this.deckId});

  @override
  _FlashcardQuizState createState() => _FlashcardQuizState();
}

class _FlashcardQuizState extends State<FlashcardQuiz> {
  List<Flashcard> _flashcards = [];
  int _currentIndex = 0;
  int _viewedAnswers = 0;
  bool _isAnswerVisible = false;
  Set<String> _viewedFlashcardIds = {};

  @override
  void didChangeDependencies() {
    DBHelper.getCardsByDeckId(widget.deckId).then((flashcards) {
      setState(() {
        _flashcards = flashcards;
        _flashcards.shuffle(Random());
      });
    });
    super.didChangeDependencies();
  }

  void _showAnswer() {
    setState(() {
      _isAnswerVisible = !_isAnswerVisible;
      if (_isAnswerVisible) {
        if (!_viewedFlashcardIds.contains(_flashcards[_currentIndex].id)) {
          _viewedAnswers++;
          _viewedFlashcardIds.add(_flashcards[_currentIndex].id);
        }
      }
    });
  }

  void _nextCard() {
    setState(() {
      if (_currentIndex < _flashcards.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _isAnswerVisible = false;
    });
  }

  void _prevCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = _flashcards.length - 1;
      }
      _isAnswerVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Quiz'),
      ),
      body: _flashcards.isEmpty
          ? Center(
              child: Text('No flashcards to quiz'),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Card ${_currentIndex + 1} / ${_flashcards.length}',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Text(
                  'Viewed Answers: $_viewedAnswers',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 40),
                Container(
                  height: 300,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Card(
                      color: _isAnswerVisible
                        ? Colors.green[100]
                        : Colors.purple[100],
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: _showAnswer,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _isAnswerVisible ? _flashcards[_currentIndex].answer : _flashcards[_currentIndex].question,
                                  style: TextStyle(fontSize: 24),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _prevCard,
                      child: Text('Prev'),
                    ),
                    ElevatedButton(
                      onPressed: _showAnswer,
                      child: Text(_isAnswerVisible ? 'Hide Answer' : 'Show Answer'),
                    ),
                    ElevatedButton(
                      onPressed: _nextCard,
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
