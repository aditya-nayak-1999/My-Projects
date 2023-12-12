import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../models/user_model.dart';

class AuthController with ChangeNotifier {
  UserModel? _currentUser;
  final LocalStorageService _localStorageService;
  final ApiService _apiService;

  AuthController(this._localStorageService, this._apiService);

  UserModel? get currentUser => _currentUser;

  Future<void> register(String username, String password) async {
    try {
      var response = await _apiService.register(username, password);
      _currentUser = UserModel(username: username, token: response['access_token']);
      await _localStorageService.saveToken(_currentUser!.token);
      notifyListeners();
    } catch (e) {
      debugPrint('Registration error: $e');
      throw Exception('Failed to register.');
    }
  }

  Future<void> login(String username, String password) async {
    try {
      var response = await _apiService.login(username, password);
      if (response['access_token'] != null) {
        _currentUser = UserModel(username: username, token: response['access_token']);
        await _localStorageService.saveToken(_currentUser!.token);
        notifyListeners();
      } else {
        throw Exception(response['message'] ?? 'Failed to login.');
      }
    } catch (e) {
      debugPrint('Login error: $e');
      throw Exception('Failed to login.');
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await _localStorageService.clearToken();
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    String? token = await _localStorageService.getToken();
    if (token != null) {
      var response = await _apiService.verifyToken(); 
      if (response['valid']) {
        _currentUser = UserModel(username: response['username'], token: token);
        notifyListeners();
        return true;
      }
    }
    return false;
  }
}
