import 'package:flutter/material.dart';
import '../views/yahtzee.dart';

void main() => runApp(YahtzeeApp());            // Entry point of the app

class YahtzeeApp extends StatelessWidget {      // Main app widget
  @override
  Widget build(BuildContext context) {          // Method to describe UI of the app
    return MaterialApp(
      title: 'Yahtzee Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Yahtzee(),
    );
  }
}
