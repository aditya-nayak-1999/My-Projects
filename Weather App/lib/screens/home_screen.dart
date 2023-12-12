import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/shared_preferences_service.dart';
import '../services/weather_api_service.dart';
import 'weather_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> favoriteLocations = [];
  final weatherApiService = WeatherApiService();
  String temperatureUnit = '°C'; 

  @override
  void initState() {
    super.initState();
    _loadFavoriteLocations();
    _loadUnitOfMeasurement();
  }

  void _loadUnitOfMeasurement() async {
    String unit = await SharedPreferencesService.getUnitOfMeasurement();
    setState(() {
      temperatureUnit = unit == 'Metric' ? '°C' : '°F';
    });
  }

  void _loadFavoriteLocations() async {
    favoriteLocations = await SharedPreferencesService.getFavoriteLocations();
    setState(() {});
  }

  void _addLocation(String location) async {
    await SharedPreferencesService.addFavoriteLocation(location);
    _loadFavoriteLocations();
  }

  void _removeLocation(String location) async {
    await SharedPreferencesService.removeFavoriteLocation(location);
    _loadFavoriteLocations();
  }

  void _addNewLocation(BuildContext context) async {
    TextEditingController locationController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a New Location'),
          content: TextField(
            controller: locationController,
            decoration: InputDecoration(hintText: 'Enter Location Name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (locationController.text.isNotEmpty) {
                  _addLocation(locationController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SimpleWeather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings').then((_) {
                _loadUnitOfMeasurement(); 
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: favoriteLocations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              favoriteLocations[index],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: FutureBuilder<WeatherModel>(
              future: weatherApiService.getWeatherByCityName(favoriteLocations[index]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...', style: TextStyle(fontSize: 18));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 18));
                } else {
                  return Text(
                    'Temperature: ${snapshot.data?.temperature.toStringAsFixed(1)}$temperatureUnit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  );
                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherDetailScreen(location: favoriteLocations[index])),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeLocation(favoriteLocations[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewLocation(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
