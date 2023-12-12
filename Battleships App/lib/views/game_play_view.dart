import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import '../models/game_model.dart';

class GamePlayView extends StatefulWidget {
  final int gameId;

  GamePlayView({Key? key, required this.gameId}) : super(key: key);

  @override
  _GamePlayViewState createState() => _GamePlayViewState();
}

class _GamePlayViewState extends State<GamePlayView> {
  late GameModel _currentGame;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGameDetails();
  }

  Future<void> _fetchGameDetails() async {
    setState(() => _isLoading = true);
    final gameController = Provider.of<GameController>(context, listen: false);
    await gameController.fetchGameDetails(widget.gameId);
    setState(() {
      _currentGame = gameController.getGameById(widget.gameId);
      _isLoading = false;
    });
  }

  void _playShot(String position) async {
    final gameController = Provider.of<GameController>(context, listen: false);
    if (_currentGame.turn != _currentGame.position || _currentGame.status != 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('It is not your turn or the game is not active.'),
      ));
      return;
    }
    setState(() => _isLoading = true);
    try {
      await gameController.playShot(widget.gameId, position);
      _fetchGameDetails();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() => _isLoading = false);
  }

  Widget _buildGameTile(String position) {
    bool isShipPosition = _currentGame.ships.contains(position);
    bool isHit = _currentGame.hits.contains(position);
    bool isMiss = _currentGame.misses.contains(position);
    bool isSunk = _currentGame.sunkShips.contains(position);

    Widget? tileChild;
    if (isSunk) {
      tileChild = Image.asset('assets/Sunk.png');
    } else if (isHit) {
      tileChild = Image.asset('assets/Hit.png');
    } else if (isMiss) {
      tileChild = Image.asset('assets/Miss.png');
    } else if (isShipPosition) {
      tileChild = Image.asset('assets/ShipPosition.png');
    }

    return GestureDetector(
      onTap: () => isHit || isMiss || isSunk || _isLoading ? null : _playShot(position),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, 
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
        child: tileChild,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game #${widget.gameId}'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: 25,
              itemBuilder: (context, index) {
                String rowLabel = String.fromCharCode('A'.codeUnitAt(0) + index ~/ 5);
                String colLabel = (index % 5 + 1).toString();
                return _buildGameTile('$rowLabel$colLabel');
              },
            ),
    );
  }
}
