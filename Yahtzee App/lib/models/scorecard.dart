class ScoreCard {                                               // Scorecard class
  Map<String, int?> _scores = {};                               // Map to store scores for each section

  ScoreCard() {                                                 // Initialize all sections to null
    _scores = {
      'Ones': null,
      'Twos': null,
      'Threes': null,
      'Fours': null,
      'Fives': null,
      'Sixes': null,
      'Three of a Kind': null,
      'Four of a Kind': null,
      'Full House': null,
      'Small Straight': null,
      'Large Straight': null,
      'Yahtzee': null,
      'Chance': null,
    };
  }

  List<String> get sections => _scores.keys.toList();           // Getter to fetch all section names
  int get totalScore => getTotalScore();                        // Getter to compute and return the total score

  int? getScore(String section) => _scores[section];            // Get the current score for a specific section

  bool isPicked(String section) => _scores[section] != null;    // Check if a section has been picked

  void setScore(String section, int value) {                    // Set the score for a specific section
    if (_scores[section] == null) {
      _scores[section] = value;
    }
  }

  int getTotalScore() {                                         // Calculate the total current score
    return _scores.values.where((score) => score != null).fold(0, (a, b) => a + b!);
  }

  bool allSectionsPicked() {                                    // Check if all sections are picked
    return _scores.values.every((score) => score != null);
  }

  void reset() {                                                // Reset the scorecard for a new game
    _scores.keys.forEach((key) {
      _scores[key] = null;
    });
  }
}
