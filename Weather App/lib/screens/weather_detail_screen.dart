import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_api_service.dart';
import '../services/shared_preferences_service.dart';

class WeatherDetailScreen extends StatefulWidget {
  final String location;

  WeatherDetailScreen({required this.location});

  @override
  _WeatherDetailScreenState createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  late WeatherModel weatherData;
  final weatherApiService = WeatherApiService();
  bool isLoading = true;
  String? errorMessage;
  String temperatureUnit = '°C'; 
  String windSpeedUnit = 'm/s'; 

  @override
  void initState() {
    super.initState();
    _loadUnitOfMeasurement();
    _loadWeatherData();
  }

  void _loadUnitOfMeasurement() async {
    String unit = await SharedPreferencesService.getUnitOfMeasurement();
    setState(() {
      temperatureUnit = unit == 'Metric' ? '°C' : '°F';
      windSpeedUnit = unit == 'Metric' ? 'm/s' : 'mph'; 
    });
  }

  void _loadWeatherData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      weatherData = await weatherApiService.getWeatherByCityName(widget.location);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Detail: ${widget.location}'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadWeatherData,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
            ? Center(child: Text('Error: $errorMessage'))
            : _buildWeatherDetails(),
    );
  }
  Widget _buildWeatherDetails() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Temperature: ${weatherData.temperature.toStringAsFixed(1)}$temperatureUnit',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8), 
          Text(
            'Humidity: ${weatherData.humidity}%',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            'Wind Speed: ${weatherData.windSpeed} $windSpeedUnit',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            'Description: ${weatherData.weatherDescription}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

