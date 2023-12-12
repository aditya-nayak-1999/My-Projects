import 'package:http/http.dart' as http;
import 'dart:convert';
import 'local_storage_service.dart';

class ApiService {
  final String _baseUrl = 'http://165.227.117.48';
  final LocalStorageService _localStorageService;

  ApiService(this._localStorageService);

  Future<String> _getAuthHeader() async {
    final token = await _localStorageService.getToken();
    if (token == null) throw Exception('No token found. Please login.');
    return 'Bearer $token';
  }

  Future<Map<String, dynamic>> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register with status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login with status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> verifyToken() async {
    final authHeader = await _getAuthHeader();
    final response = await http.get(
      Uri.parse('$_baseUrl/verifyToken'),
      headers: {'Authorization': authHeader},
    );

    if (response.statusCode == 200) {
      return {'valid': true, 'username': json.decode(response.body)['username']};
    } else {
      return {'valid': false};
    }
  }
  
  Future<Map<String, dynamic>> getGames() async {
    final authHeader = await _getAuthHeader();
    final response = await http.get(
      Uri.parse('$_baseUrl/games'),
      headers: {'Authorization': authHeader},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch games with status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getGameDetails(int gameId) async {
    final authHeader = await _getAuthHeader();
    final response = await http.get(
      Uri.parse('$_baseUrl/games/$gameId'),
      headers: {'Authorization': authHeader},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get game details with status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> startGame(List<String> shipPositions, {String? ai}) async {
    var body = json.encode({
      'ships': shipPositions,
      if (ai != null) 'ai': ai,
    });

    final response = await http.post(
      Uri.parse('$_baseUrl/games'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': await _getAuthHeader(),
      },
      body: body,
    );

    var jsonResponse = json.decode(response.body);
    print('Response from the server: $jsonResponse'); 
    if (response.statusCode == 200) {
      return jsonResponse;
    } else {
      throw Exception('Failed to start new game with status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> playShot(int gameId, String shotPosition) async {
    final authHeader = await _getAuthHeader();
    final response = await http.put(
      Uri.parse('$_baseUrl/games/$gameId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': authHeader,
      },
      body: json.encode({'shot': shotPosition}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to play shot with status code: ${response.statusCode}');
    }
  }

  Future<void> deleteGame(int gameId) async {
    final authHeader = await _getAuthHeader();
    final response = await http.delete(
      Uri.parse('$_baseUrl/games/$gameId'),
      headers: {'Authorization': authHeader},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete game with status code: ${response.statusCode}');
    }
  }
}
