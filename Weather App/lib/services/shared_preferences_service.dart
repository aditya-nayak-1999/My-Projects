import 'package:shared_preferences/shared_preferences.dart';
import '../services/weather_api_service.dart';

class SharedPreferencesService {
  static Future<List<String>> getFavoriteLocations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> locations = prefs.getStringList('favoriteLocations') ?? [];
      locations = await _validateLocations(locations);
      return locations;
    } catch (e) {
      print('Error fetching favorite locations: $e');
      return [];
    }
  }

  static Future<void> addFavoriteLocation(String location) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locations = prefs.getStringList('favoriteLocations') ?? [];
      if (!locations.contains(location)) {
        if (await _isValidLocation(location)) {
          locations.add(location);
          await prefs.setStringList('favoriteLocations', locations);
        }
      }
    } catch (e) {
      print('Error adding favorite location: $e');
    }
  }

  static Future<void> removeFavoriteLocation(String location) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locations = prefs.getStringList('favoriteLocations') ?? [];
      locations.remove(location);
      await prefs.setStringList('favoriteLocations', locations);
    } catch (e) {
      print('Error removing favorite location: $e');
    }
  }

  static Future<void> setUnitOfMeasurement(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('unitOfMeasurement', unit);
  }

  static Future<String> getUnitOfMeasurement() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('unitOfMeasurement') ?? 'metric'; 
  }

  static Future<bool> _isValidLocation(String location) async {
    try {
      final weatherApiService = WeatherApiService();
      await weatherApiService.getWeatherByCityName(location);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<String>> _validateLocations(List<String> locations) async {
    List<String> validLocations = [];
    for (String location in locations) {
      if (await _isValidLocation(location)) {
        validLocations.add(location);
      }
    }
    return validLocations;
  }
}
