import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../models/deck.dart';
import '../utils/db_helper.dart';

class FlashcardProvider with ChangeNotifier {
  List<Deck> _decks = [];

  List<Deck> get decks {
    return [..._decks];
  }

  FlashcardProvider() {
    loadDecksFromDB();
  }
  
  Future<void> loadDecksFromDB() async {
    _decks = await DBHelper.fetchDecks();
    notifyListeners();
  }

  void addDeck(String title) {
    final newDeck = Deck(id: DateTime.now().toString(), title: title, cards: []);
    _decks.add(newDeck);
    notifyListeners();
    DBHelper.insertDeck(newDeck);
  }

  void addDeckWithCards(String title, List<Flashcard> cards) {
    final newDeck = Deck(id: DateTime.now().toString(), title: title, cards: cards);
    _decks.add(newDeck);
    notifyListeners();
    DBHelper.insertDeck(newDeck);
  }

  Deck findById(String id) {
    return _decks.firstWhere((deck) => deck.id == id);
  }

  Deck findDeckById(String id) {
    return _decks.firstWhere((deck) => deck.id == id, orElse: () => Deck(id: '', title: '', cards: []));
  }

  Flashcard findCardById(String deckId, String? cardId) {
    final deckIndex = _decks.indexWhere((deck) => deck.id == deckId);
    if (deckIndex != -1 && cardId != null) {
      return _decks[deckIndex].cards.firstWhere((card) => card.id == cardId);
    }
    return Flashcard(id: '', question: '', answer: '');
  }

  void updateDeck(String id, String newTitle) {
    final deckIndex = _decks.indexWhere((deck) => deck.id == id);
    if (deckIndex >= 0) {
      _decks[deckIndex].title = newTitle;
      notifyListeners();
    }
  }

  void deleteDeck(String id) {
    DBHelper.deleteDeck(id);
    final existingDeckIndex = _decks.indexWhere((deck) => deck.id == id);
    if (existingDeckIndex != -1) {
      _decks.removeAt(existingDeckIndex);
      notifyListeners();
    }
  }

  void addCard(String deckId, String question, String answer) {
    final newCard = Flashcard(
      id: DateTime.now().toString(),
      question: question,
      answer: answer,
    );
    final deckIndex = _decks.indexWhere((deck) => deck.id == deckId);
    if (deckIndex != -1) {
      _decks[deckIndex].cards.add(newCard);
      notifyListeners();
    }
  }

  void updateCard(String deckId, String cardId, String newQuestion, String newAnswer) {
    final deckIndex = _decks.indexWhere((deck) => deck.id == deckId);
    if (deckIndex != -1) {
      final cardIndex = _decks[deckIndex].cards.indexWhere((card) => card.id == cardId);
      if (cardIndex != -1) {
        final updatedCard = Flashcard(
          id: cardId,
          question: newQuestion,
          answer: newAnswer,
        );
        _decks[deckIndex].cards[cardIndex] = updatedCard;
        notifyListeners();
      }
    }
  }

  void sortCardsAlphabetically(String deckId) {
    final deckIndex = _decks.indexWhere((deck) => deck.id == deckId);
    if (deckIndex != -1) {
      _decks[deckIndex].cards.sort((a, b) => a.question.compareTo(b.question));
      notifyListeners();
    }
  }

  void deleteCard(String deckId, String cardId) {
    final deckIndex = _decks.indexWhere((deck) => deck.id == deckId);
    if (deckIndex != -1) {
      _decks[deckIndex].cards.removeWhere((card) => card.id == cardId);
      notifyListeners();
    }
  }

}
