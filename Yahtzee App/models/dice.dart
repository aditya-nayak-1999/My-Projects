import 'dart:math';

class Dice {                          // Single dice
  int? _value; 
  bool _isLocked = false;

  int? get value => _value;           // Getter to fetch the dice value

  bool get isLocked => _isLocked;     // Getter to know if the dice is locked

  void roll() {                       // Method to roll the dice if it is not locked
    if (!_isLocked) {
      _value = (1 + Random().nextInt(6));
    }
  }

  void toggleLock() {                 // Method to change the lock status of the dice
    _isLocked = !_isLocked;
  }

  void reset() {                      // Method to reset the dice
    _value = null;
    _isLocked = false;
  }
}
