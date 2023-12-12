import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';

class CardForm extends StatefulWidget {
  final String deckId;
  final String? cardId;

  CardForm({required this.deckId, this.cardId});

  @override
  _CardFormState createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();
  var _editedCard = Flashcard(
    id: '',
    question: '',
    answer: '',
  );
  var _initValues = {
    'question': '',
    'answer': '',
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (widget.cardId != null) {
        _editedCard = Provider.of<FlashcardProvider>(context, listen: false).findCardById(widget.deckId, widget.cardId!);
        _initValues = {
          'question': _editedCard.question,
          'answer': _editedCard.answer,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    if (_editedCard.id.isNotEmpty) {
      Provider.of<FlashcardProvider>(context, listen: false).updateCard(widget.deckId, _editedCard.id, _editedCard.question, _editedCard.answer);
    } else {
      Provider.of<FlashcardProvider>(context, listen: false).addCard(widget.deckId, _editedCard.question, _editedCard.answer);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['question'],
                decoration: InputDecoration(labelText: 'Question'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _editedCard = Flashcard(
                    id: _editedCard.id,
                    question: value ?? '',
                    answer: _editedCard.answer,
                  );
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['answer'],
                decoration: InputDecoration(labelText: 'Answer'),
                textInputAction: TextInputAction.next, 
                onSaved: (value) {
                  _editedCard = Flashcard(
                    id: _editedCard.id,
                    question: _editedCard.question,
                    answer: value ?? '',
                  );
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter an answer.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
