import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/auth_view.dart';
import 'views/game_list_view.dart';
import 'views/place_ships_view.dart'; 
import 'views/game_play_view.dart'; 
import 'controllers/auth_controller.dart';
import 'controllers/game_controller.dart';
import 'services/api_service.dart';
import 'services/local_storage_service.dart';

void main() {
  runApp(BattleshipsApp());
}

class BattleshipsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localStorageService = LocalStorageService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(
            localStorageService,
            ApiService(localStorageService),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => GameController(
            ApiService(localStorageService), 
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Battleships',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: AuthView(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/game_list':
              return MaterialPageRoute(builder: (_) => GameListView());
            case '/place_ships':
              final isAI = settings.arguments as bool? ?? false;
              return MaterialPageRoute(builder: (_) => PlaceShipsView(isAI: isAI));
            case '/game_play':
              final gameId = settings.arguments as int?;
              if (gameId != null) {
                return MaterialPageRoute(builder: (_) => GamePlayView(gameId: gameId));
              } else {
                return MaterialPageRoute(builder: (_) => GameListView());
              }
            case '/completed_games':
              return MaterialPageRoute(builder: (_) => CompletedGamesView());
            default:
              return MaterialPageRoute(builder: (_) => AuthView());
          }
        },
      ),
    );
  }
}
