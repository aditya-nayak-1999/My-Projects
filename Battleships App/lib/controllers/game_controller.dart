import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/game_model.dart';

class GameController with ChangeNotifier {
  final ApiService _apiService;
  List<GameModel> _games = [];

  GameController(this._apiService);

  List<GameModel> get activeGames => _games.where((game) => !game.isCompleted).toList();
  List<GameModel> get completedGames => _games.where((game) => game.isCompleted).toList();

  bool get hasActiveGames => activeGames.isNotEmpty;
  bool get hasCompletedGames => completedGames.isNotEmpty;

  GameModel getGameById(int gameId) {
    return _games.firstWhere(
      (game) => game.id == gameId, 
      orElse: () => GameModel.empty(),
    );
  }

  Future<void> fetchGames({bool onlyActive = true}) async {
    try {
      var response = await _apiService.getGames();
      var allGames = (response['games'] as List)
          .map((gameJson) => GameModel.fromJson(gameJson))
          .toList();

      _games = onlyActive 
          ? allGames.where((game) => !game.isCompleted).toList()
          : allGames;
    } catch (e) {
      debugPrint('Error fetching games: $e');
      _games = [];
    }
    notifyListeners();
  }

  Future<void> deleteGame(int gameId) async {
    try {
      await _apiService.deleteGame(gameId);
      _games.removeWhere((game) => game.id == gameId);
    } catch (e) {
      debugPrint('Error deleting game: $e');
    }
    notifyListeners();
  }

  Future<int> createNewGame({String? aiType}) async {
    try {
      var response = await _apiService.startGame([], ai: aiType); 
      var newGame = GameModel.fromJson(response);
      _games.add(newGame);
      notifyListeners();
      return newGame.id;
    } catch (e) {
      debugPrint('Error creating game: $e');
      rethrow; 
    }
  }

  Future<void> startGame(List<String> shipPositions, {String? aiType}) async {
    try {
      var response = await _apiService.startGame(shipPositions, ai: aiType);
      var newGame = GameModel.fromJson(response);
      _games.add(newGame);
      notifyListeners();
    } catch (e) {
      debugPrint('Error starting game: $e');
      throw Exception('Failed to start the game.');
    }
  }

  Future<int> startGameWithShips(List<String> shipPositions, {String? aiType}) async {
    if (shipPositions.length != 5 || shipPositions.any((pos) => pos.isEmpty)) {
      throw Exception('Invalid ship positions provided. Must be exactly 5 non-empty strings.');
    }

    try {
      var response = await _apiService.startGame(shipPositions, ai: aiType);
      print('Response from startGame: $response'); 
  
      var newGame = GameModel(
        id: response['id'] ?? -1,
        player1: '', 
        player2: '', 
        position: response['player'] ?? -1, 
        status: 0, 
        turn: 0, 
      );

      _games.add(newGame);
      notifyListeners();
      return newGame.id;
    } catch (e) {
      debugPrint('Error starting game with ships: $e');
      throw Exception('Failed to start the game with ships: $e');
    }
  }

  Future<void> playShot(int gameId, String shotPosition) async {
    try {
      var response = await _apiService.playShot(gameId, shotPosition);
      var gameIndex = _games.indexWhere((game) => game.id == gameId);
      if (gameIndex != -1) {
        var game = _games[gameIndex];
        _updateGameState(game, response);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error playing shot: $e');
      rethrow; 
    }
  }
  
  void _updateGameState(GameModel game, Map<String, dynamic> response) {
    var shot = response['shot'];
    if (shot != null && response['sunk_ship']) {
      game.sunkShips.add(shot);
    }
  }

  Future<void> playTurn(int gameId, String shotPosition) async {
    try {
      var response = await _apiService.playShot(gameId, shotPosition);
      var gameIndex = _games.indexWhere((game) => game.id == gameId);
      if (gameIndex != -1) {
        var game = _games[gameIndex];
        if (response['sunk_ship']) {
          game.sunkShips.add(shotPosition);
          game.hits.add(shotPosition); 
        } else {
          game.misses.add(shotPosition); 
        }
        if (response['won']) {
          game.status = response['status'];
        }
        _games[gameIndex] = game; 
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error playing turn: $e');
      throw Exception('Failed to play turn.');
    }
  }

  Future<void> fetchGameDetails(int gameId) async {
    try {
      if (gameId <= 0) {
        debugPrint('Invalid game ID: $gameId');
        return;
      }
      var response = await _apiService.getGameDetails(gameId);
      var gameIndex = _games.indexWhere((game) => game.id == gameId);
      if (gameIndex != -1) {
        _games[gameIndex] = GameModel.fromJson(response);
        notifyListeners();
      } else {
        debugPrint('Game with ID $gameId not found in the list');
      }
    } catch (e) {
      debugPrint('Error fetching game details: $e');
    }
  }

}
