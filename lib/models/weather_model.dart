class WeatherModel {
  final String cityName;
  final double temperature;
  final int weatherCode;
  final String weatherMain;
  final String description;
  final String sunrise;
  final String sunset;
  final double humidity;
  final double windSpeed;
  final DateTime timestamp;
  final double visibility;
  final double feelsLike;
  final double lat;
  final double lon;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherMain,
    required this.description,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.visibility,
    required this.feelsLike,
    required this.timestamp,
    required this.lat,
    required this.lon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    final current = json['current'];
    final daily = json['daily'];

    return WeatherModel(
      cityName: cityName,
      temperature: (current['temperature_2m'] as num).toDouble(),
      weatherCode: current['weather_code'] as int,
      weatherMain: _getWeatherMain(current['weather_code'] as int),
      description: _getWeatherMain(current['weather_code'] as int),
      sunrise: daily['sunrise'][0] as String,
      sunset: daily['sunset'][0] as String,
      humidity: (current['relative_humidity_2m'] as num).toDouble(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      visibility: (current['visibility'] as num).toDouble(),
      feelsLike: (current['apparent_temperature']as num).toDouble(),
      timestamp: DateTime.now(),
      lat: (json['latitude'] as num).toDouble(),
      lon: (json['longitude'] as num).toDouble(),
    );
  }
  static String _getWeatherMain(int code){
    if (code == 0) return 'Clear';
    if (code <= 2) return 'Partly Cloudy';
    if (code == 3) return 'Cloudy';
    if (code <= 48) return 'Fog';
    if (code <= 55) return 'Drizzle';
    if (code <= 65) return 'Rain';
    if (code <= 75) return 'Snow';
    if (code <= 82) return 'Rain';
    return 'Thunderstorm';
  }
}