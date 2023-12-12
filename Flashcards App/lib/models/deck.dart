import '../models/flashcard.dart';

class Deck {
  String id;
  String title;
  List<Flashcard> cards;

  Deck({required this.id, required this.title, required this.cards});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
