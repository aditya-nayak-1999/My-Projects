import 'package:flutter/widgets.dart';
import '../services/local_storage_service.dart';

class SessionController with ChangeNotifier {
  final LocalStorageService _localStorageService = LocalStorageService();
  String? _token;

  String? get token => _token;

  Future<void> loadToken() async {
    _token = await _localStorageService.getToken();
    notifyListeners();
  }

  Future<void> updateToken(String? newToken) async {
    if (newToken == null) {
      await _localStorageService.clearToken();
    } else {
      await _localStorageService.saveToken(newToken);
    }
    _token = newToken;
    notifyListeners();
  }

  Future<void> clearSession() async {
    await _localStorageService.clearToken();
    _token = null;
    notifyListeners();
  }
}
