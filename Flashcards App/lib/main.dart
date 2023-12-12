import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';
import '../views/add_deck.dart';
import '../views/decklist.dart';
import '../views/flashcard_quiz.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final flashcardProvider = FlashcardProvider();
  await flashcardProvider.loadDecksFromDB();
  runApp(
    ChangeNotifierProvider.value(
      value: flashcardProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DeckList(),
      routes: {
        '/add-deck': (ctx) => AddEditDeck(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == FlashcardQuiz.routeName) {
          final String deckId = settings.arguments as String;
          return MaterialPageRoute(builder: (ctx) => FlashcardQuiz(deckId: deckId));
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
