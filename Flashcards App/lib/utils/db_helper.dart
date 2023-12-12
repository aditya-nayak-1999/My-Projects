import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/flashcard.dart';
import '../models/deck.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'flashcards.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE decks(id TEXT PRIMARY KEY, title TEXT)',
        );
        db.execute(
          'CREATE TABLE cards(id TEXT PRIMARY KEY, question TEXT, answer TEXT, deckId TEXT, FOREIGN KEY(deckId) REFERENCES decks(id))',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE decks ADD COLUMN isDeleted INTEGER DEFAULT 0',
          );
        }
      },
      version: 2,
    );
  }

  static Future<void> insertDeck(Deck deck) async {
    final db = await DBHelper.database();
    await db.transaction((txn) async {
      await txn.insert(
        'decks',
        {
          ...deck.toMap(),
          'isDeleted': 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      for (Flashcard card in deck.cards) {
        await txn.insert(
          'cards',
          card.toMap(deck.id),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  static Future<void> insertCard(Flashcard card, String deckId) async {
    final db = await DBHelper.database();
    db.insert(
      'cards',
      card.toMap(deckId),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Deck>> fetchDecks() async {
    final db = await DBHelper.database();
    final decksData = await db.query('decks', where: 'isDeleted = 0');
    List<Deck> loadedDecks = [];

    for (var deckData in decksData) {
      final cardsData = await db.query('cards', where: 'deckId = ?', whereArgs: [deckData['id']]);
      List<Flashcard> loadedCards = cardsData.map((cardData) => Flashcard.fromMap(cardData)).toList();

      loadedDecks.add(Deck(
        id: deckData['id'].toString(),
        title: deckData['title'].toString(),
        cards: loadedCards,
      ));
    }

    return loadedDecks;
  }

  static Future<void> deleteDeck(String deckId) async {
    final db = await DBHelper.database();
    await db.update(
      'decks',
      {'isDeleted': 1},
      where: 'id = ?',
      whereArgs: [deckId],
    );
  }

  static Future<List<Flashcard>> getCardsByDeckId(String deckId) async {
    final db = await DBHelper.database();
    final cardsData = await db.query('cards', where: 'deckId = ?', whereArgs: [deckId]);
    return cardsData.map((cardData) => Flashcard.fromMap(cardData)).toList();
  }

  static Future<void> deleteCard(String cardId) async {
    final db = await DBHelper.database();
    await db.delete(
      'cards',
      where: 'id = ?',
      whereArgs: [cardId],
    );
  }

}
