import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/deck.dart';
import '../models/flashcard.dart';
import '../views/card_form.dart';
import '../views/flashcard_quiz.dart';
import '../providers/flashcard_provider.dart';

class DeckDetail extends StatefulWidget {
  static const routeName = '/deck-detail';
  final Deck deck;

  DeckDetail(this.deck);

  @override
  _DeckDetailState createState() => _DeckDetailState();
}

class _DeckDetailState extends State<DeckDetail> {
  bool _isSortedAlphabetically = false;
  late List<Flashcard> _originalOrder;

  @override
  void initState() {
    super.initState();
    _originalOrder = List.from(widget.deck.cards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.deck.title)),
        actions: [
          IconButton(
            icon: _isSortedAlphabetically
                ? Icon(Icons.access_time)
                : Text("AZ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onPressed: _sortCards,
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.of(context).pushNamed(
                FlashcardQuiz.routeName,
                arguments: widget.deck.id,
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<FlashcardProvider>(
              builder: (context, flashcardProvider, child) {
                final deck = flashcardProvider.findDeckById(widget.deck.id);
                final cards = deck.cards;

                if (cards.isEmpty) {
                  return Center(child: Text('No cards found'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return Card(
                      color: Colors.purple[100],
                      child: Container(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () => _editCard(card),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(card.question, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _deleteCard(card),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CardForm(deckId: widget.deck.id),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _editCard(Flashcard card) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CardForm(cardId: card.id, deckId: widget.deck.id),
      ),
    );
  }

  void _deleteCard(Flashcard card) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to remove this card?'),
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
              Provider.of<FlashcardProvider>(context, listen: false).deleteCard(widget.deck.id, card.id);
              Navigator.of(ctx).pop(); 
              setState(() {}); 
            },
          ),
        ],
      ),
    );
  }

  void _sortCards() {
    setState(() {
      if (_isSortedAlphabetically) {
        widget.deck.cards = List.from(_originalOrder);
      } else {
        widget.deck.cards.sort((a, b) => a.question.compareTo(b.question));
      }
      _isSortedAlphabetically = !_isSortedAlphabetically;
    });
  }
}
