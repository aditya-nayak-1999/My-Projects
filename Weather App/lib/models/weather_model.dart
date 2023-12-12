class WeatherModel {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String weatherDescription;
  final String weatherIcon;

  WeatherModel({
    required this.temperature, 
    required this.humidity, 
    required this.windSpeed, 
    required this.weatherDescription, 
    required this.weatherIcon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    double getDouble(dynamic value) {
      if (value is int) {
        return value.toDouble();
      } else if (value is double) {
        return value;
      } else {
        throw Exception('Expected double or int');
      }
    }

    return WeatherModel(
      temperature: getDouble(json['main']['temp']),
      humidity: json['main']['humidity'],
      windSpeed: getDouble(json['wind']['speed']),
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
    );
  }
}
