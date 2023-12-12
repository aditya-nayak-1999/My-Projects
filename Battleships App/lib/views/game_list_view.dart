import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import '../controllers/auth_controller.dart';
import '../views/game_play_view.dart';
import '../views/place_ships_view.dart';

class GameListView extends StatefulWidget {
  @override
  _GameListViewState createState() => _GameListViewState();
}

class _GameListViewState extends State<GameListView> {
  bool showCompletedGames = false;

  @override
  void initState() {
    super.initState();
    _fetchGamesList();
  }

  void _toggleCompletedGames() {
    setState(() {
      showCompletedGames = !showCompletedGames;
    });
    _fetchGamesList();
  }

  void _fetchGamesList() {
    if (showCompletedGames) {
      Provider.of<GameController>(context, listen: false).fetchGames(onlyActive: false);
    } else {
      Provider.of<GameController>(context, listen: false).fetchGames();
    }
  }

  void _navigateToPlaceShips({bool isAI = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceShipsView(isAI: isAI),
      ),
    );
  }

  void _logout() async {
    try {
      await Provider.of<AuthController>(context, listen: false).logout();
      Navigator.pushReplacementNamed(context, '/auth');
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $error')),
      );
    }
  }

  Widget _buildDrawer(AuthController authController) {
    final username = authController.currentUser?.username ?? 'Guest';
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Logged in as $username'),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                username.isNotEmpty ? username[0].toUpperCase() : '?',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('New game (Human)'),
            onTap: () {
              Navigator.pop(context); 
              _navigateToPlaceShips(); 
            },
          ),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text('New game (AI)'),
            onTap: () {
              Navigator.pop(context); 
              _navigateToPlaceShips(isAI: true); 
            },
          ),
          ListTile(
            leading: Icon(showCompletedGames ? Icons.list : Icons.history),
            title: Text(showCompletedGames ? 'Show active games' : 'Show completed games'),
            onTap: () {
              Navigator.pop(context);
              _toggleCompletedGames();
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: () {
              Navigator.pop(context);
              _logout();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    final authController = Provider.of<AuthController>(context);
    final gamesToShow = showCompletedGames
        ? gameController.completedGames
        : gameController.activeGames;

    return Scaffold(
      appBar: AppBar(
        title: Text(showCompletedGames ? 'Completed Games' : 'Active Games'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchGamesList,
          ),
        ],
      ),
      drawer: _buildDrawer(authController),
      body: gamesToShow.isEmpty
          ? Center(child: Text('No games available.'))
          : ListView.builder(
              itemCount: gamesToShow.length,
              itemBuilder: (context, index) {
                final game = gamesToShow[index];
                return ListTile(
                  title: Text('Game ${game.id}'),
                  subtitle: Text('Status: ${game.statusDescription}'),
                  onTap: () {
                    if (game.status == 0) {
                      _navigateToPlaceShips();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GamePlayView(gameId: game.id),
                        ),
                      );
                    }
                  },
                  trailing: game.status == 0
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await gameController.deleteGame(game.id);
                            _fetchGamesList();
                          },
                        )
                      : null,
                );
              },
            ),
    );
  }
}

class CompletedGamesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Games'),
      ),
      body: Center(child: Text('Completed games list will appear here.')),
    );
  }
}