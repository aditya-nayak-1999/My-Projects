import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uuid/uuid.dart';
import '../models/flashcard.dart';
import '../models/deck.dart';

Future<List<Deck>> loadStarterSet() async {
  final jsonString = await rootBundle.loadString('assets/flashcards.json');
  final List jsonResponse = json.decode(jsonString); 
  List<Deck> loadedDecks = [];
  for (var deckData in jsonResponse) {
    List<Flashcard> loadedCards = [];
    for (var cardData in deckData['flashcards']) { 
      loadedCards.add(Flashcard(
        id: Uuid().v4(), 
        question: cardData['question'],
        answer: cardData['answer'],
      ));
    }
    loadedDecks.add(Deck(
      id: Uuid().v4(), 
      title: deckData['title'],
      cards: loadedCards,
    ));
  }
  return loadedDecks;
}
