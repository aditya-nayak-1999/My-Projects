import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';

class AddEditDeck extends StatelessWidget {
  final String? deckId;
  final TextEditingController _titleController = TextEditingController();

  AddEditDeck({this.deckId});

  @override
  Widget build(BuildContext context) {
    final decksData = Provider.of<FlashcardProvider>(context, listen: false);
    if (deckId != null) {
      final existingDeck = decksData.findById(deckId!);
      _titleController.text = existingDeck.title;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(deckId == null ? 'Add Deck' : 'Edit Deck'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                if (_titleController.text.isEmpty) {
                  return;
                }
                if (deckId == null) {
                  decksData.addDeck(_titleController.text);
                } else {
                  decksData.updateDeck(deckId!, _titleController.text);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
