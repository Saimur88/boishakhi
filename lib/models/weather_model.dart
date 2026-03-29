class WeatherModel {
  final String cityName;
  final double temperature;
  final String icon;
  final String weatherMain;
  final String description;
  final int sunrise;
  final int sunset;
  final double humidity;
  final double windSpeed;
  final DateTime timestamp = DateTime.now();
  final int visibility;
  final double feelsLike;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherMain,
    required this.description,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
    required this.visibility,
    required this.feelsLike,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      icon: json['weather'][0]['icon'],
      weatherMain: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: (json['main']['humidity'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      visibility: json['visibility'] as int,
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
    );
  }
}