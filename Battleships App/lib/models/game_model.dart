class GameModel {
  final int id;
  final String player1;
  final String player2;
  final int position;
  int status;
  final int turn;
  List<String> ships = [];
  List<String> hits = [];
  List<String> misses = [];
  List<String> sunkShips = [];

  bool get isCompleted => status == 1 || status == 2;

  GameModel({
    required this.id,
    required this.player1,
    required this.player2,
    required this.position,
    required this.status,
    required this.turn,
    List<String>? ships,
    List<String>? hits,
    List<String>? misses,
    List<String>? sunkShips,
  }) : ships = ships ?? [],
       hits = hits ?? [],
       misses = misses ?? [],
       sunkShips = sunkShips ?? [];

  factory GameModel.empty() {
    return GameModel(
      id: -1,
      player1: '',
      player2: '',
      position: -1,
      status: -1,
      turn: -1,
    );
  }

  String get statusDescription {
    switch (status) {
      case 0: return 'Matchmaking';
      case 1: return 'Won by Player 1';
      case 2: return 'Won by Player 2';
      case 3: return 'In Progress';
      default: return 'Unknown';
    }
  }

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] ?? -1, 
      player1: json['player1'] ?? '', 
      player2: json['player2'] ?? '', 
      position: json['position'] ?? -1, 
      status: json['status'] ?? 0, 
      turn: json['turn'] ?? 0,
      ships: List<String>.from(json['ships'] ?? []),
      hits: List<String>.from(json['hits'] ?? []),
      misses: List<String>.from(json['misses'] ?? []),
      sunkShips: List<String>.from(json['sunkShips'] ?? []),
    );
  }
}
