import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../services/shared_preferences_service.dart';

class WeatherApiService {
  final http.Client client;
  final String apiKey = '7cffc19256d9e0f00b1f308238179182';

  WeatherApiService({http.Client? client}) : this.client = client ?? http.Client();


  Future<WeatherModel> getWeatherByCityName(String location, {String lang = 'en'}) async {
    String units = await SharedPreferencesService.getUnitOfMeasurement();
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=$units&lang=$lang')
    );
    return _processResponse(response);
  }

  Future<WeatherModel> getWeatherByCoordinates(double lat, double lon, {String units = 'metric', String lang = 'en'}) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=$units&lang=$lang')
    );
    return _processResponse(response);
  }

  Future<WeatherModel> getWeatherByCityId(int cityId, {String units = 'metric', String lang = 'en'}) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?id=$cityId&appid=$apiKey&units=$units&lang=$lang')
    );
    return _processResponse(response);
  }

  Future<WeatherModel> getWeatherByZipCode(String zipCode, String countryCode, {String units = 'metric', String lang = 'en'}) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?zip=$zipCode,$countryCode&appid=$apiKey&units=$units&lang=$lang')
    );
    return _processResponse(response);
  }

  WeatherModel _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } 
    else if (response.statusCode == 404) {
      throw Exception('Location not found. Please enter a valid location.');
    } 
    else {
      throw Exception('Failed to load weather data. Please try again later.');
    }
  }
}
