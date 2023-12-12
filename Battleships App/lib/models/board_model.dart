class TileModel {
  bool hasShip;
  bool isHit;

  TileModel({this.hasShip = false, this.isHit = false});
}

class BoardModel {
  final Map<String, TileModel> board;

  BoardModel() : board = {} {
    for (var row in 'ABCDE'.split('')) {
      for (var col = 1; col <= 5; col++) {
        board['$row$col'] = TileModel();
      }
    }
  }

  void placeShip(String position) {
    if (board[position]?.hasShip == false) {
      board[position]!.hasShip = true;
    }
  }

  void removeShip(String position) {
    if (board[position]?.hasShip == true) {
      board[position]!.hasShip = false;
    }
  }

  List<String> get placedShips {
    return board.entries
        .where((entry) => entry.value.hasShip)
        .map((entry) => entry.key)
        .toList();
  }
}
