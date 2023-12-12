import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';
import '../utils/json_initializer.dart';
import '../views/add_deck.dart';
import '../views/deck_detail.dart';

class DeckList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final decksData = Provider.of<FlashcardProvider>(context);
    final decks = decksData.decks;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Flashcard Decks')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              final starterDecks = await loadStarterSet();
              final flashcardData = Provider.of<FlashcardProvider>(context, listen: false);
              for (var deck in starterDecks) {
                flashcardData.addDeckWithCards(deck.title, deck.cards);
              }
            },
          ),
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton( 
        onPressed: () {
          Navigator.of(context).pushNamed('/add-deck');
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(4),
          children: decks.map((deck) {
            return Card(
              color: Colors.purple[100],
              child: Container(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DeckDetail(deck),
                          ),
                        );
                      },
                    ),
                    Center(child: Text(deck.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddEditDeck(deckId: deck.id)));
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text('Do you want to remove the deck?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    decksData.deleteDeck(deck.id);
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
