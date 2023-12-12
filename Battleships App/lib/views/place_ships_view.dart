import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';

class PlaceShipsView extends StatefulWidget {
  final bool isAI; 

  PlaceShipsView({Key? key, this.isAI = false}) : super(key: key); 

  @override
  _PlaceShipsViewState createState() => _PlaceShipsViewState();
}

class _PlaceShipsViewState extends State<PlaceShipsView> {
  List<String> _selectedPositions = [];

  void _togglePosition(String position) {
    setState(() {
      if (_selectedPositions.contains(position)) {
        _selectedPositions.remove(position);
      } else if (_selectedPositions.length < 5) {
        _selectedPositions.add(position);
      }
    });
  }

  Future<void> _submitShips() async {
    if (_selectedPositions.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select exactly 5 ship positions.')),
      );
      return;
    }

    final gameController = Provider.of<GameController>(context, listen: false);
    try {
      print('Selected positions: $_selectedPositions'); 
      int newGameId;
      if (widget.isAI) {
        newGameId = await gameController.startGameWithShips(_selectedPositions, aiType: "random");
      } else {
        newGameId = await gameController.startGameWithShips(_selectedPositions);
      }
      Navigator.pushReplacementNamed(context, '/game_play', arguments: newGameId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Widget _buildShipPlacementTile(String position) {
    final isSelected = _selectedPositions.contains(position);
    return GestureDetector(
      onTap: () => _togglePosition(position),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[200] : Colors.white,
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Your Ships'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1.0,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: 25,
        itemBuilder: (context, index) {
          final rowLabel = String.fromCharCode('A'.codeUnitAt(0) + index ~/ 5);
          final colLabel = (index % 5 + 1).toString();
          return _buildShipPlacementTile('$rowLabel$colLabel');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitShips,
        tooltip: 'Submit Ships',
        child: Icon(Icons.check),
      ),
    );
  }
}
