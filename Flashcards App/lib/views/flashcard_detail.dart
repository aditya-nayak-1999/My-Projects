import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';
import '../views/card_form.dart';

class FlashcardDetail extends StatelessWidget {
  final String deckId;

  FlashcardDetail(this.deckId);

  @override
  Widget build(BuildContext context) {
    final flashcardData = Provider.of<FlashcardProvider>(context);
    final cards = flashcardData.findDeckById(deckId).cards;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Detail'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              flashcardData.sortCardsAlphabetically(deckId);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(cards[i].question),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to remove this flashcard?'),
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
                        flashcardData.deleteCard(deckId, cards[i].id);
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => CardForm(deckId: deckId, cardId: cards[i].id),
              ),
            );
          },
        ),
      ),
    );
  }
}
