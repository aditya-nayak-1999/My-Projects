import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/weather_detail_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(SimpleWeatherApp());
}

class SimpleWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleWeather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/weatherDetail': (context) {
          final location = ModalRoute.of(context)?.settings.arguments as String?;
          if (location != null) {
            return WeatherDetailScreen(location: location);
          } else {
            return Scaffold(body: Center(child: Text('No location provided')));
          }
        },
        '/settings': (context) => SettingsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
