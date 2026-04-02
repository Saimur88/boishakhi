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
  final double highestTemp;
  final double lowestTemp;
  final int maxRainChance;
  final int uvIndex;
  final double daylightDuration;
  final int cloudCover;
  final double dewPoint;
  final int windDirection;

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
    required this.highestTemp,
    required this.lowestTemp,
    required this.maxRainChance,
    required this.uvIndex,
    required this.daylightDuration,
    required this.cloudCover,
    required this.dewPoint,
    required this.windDirection,

  });

  static String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12
        ? hour - 12
        : hour == 0
        ? 12
        : hour;
    return '$hour12:$minute$period';
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    final current = json['current'];
    final daily = json['daily'];


    return WeatherModel(
      cityName: cityName,
      temperature: (current['temperature_2m'] as num).toDouble(),
      weatherCode: current['weather_code'] as int,
      weatherMain: _getWeatherMain(current['weather_code'] as int),
      description: _getWeatherMain(current['weather_code'] as int),
      sunrise: _formatTime(DateTime.parse(daily['sunrise'][0])),
      sunset: _formatTime(DateTime.parse(daily['sunset'][0])),
      humidity: (current['relative_humidity_2m'] as num).toDouble(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      visibility: (current['visibility'] as num).toDouble(),
      feelsLike: (current['apparent_temperature']as num).toDouble(),
      timestamp: DateTime.now(),
      lat: (json['latitude'] as num).toDouble(),
      lon: (json['longitude'] as num).toDouble(),
      highestTemp: (daily['temperature_2m_max'] [0] as num).toDouble(),
      lowestTemp: (daily['temperature_2m_min'] [0] as num).toDouble(),
      maxRainChance: (daily['precipitation_probability_max'] [0] as num).toInt(),
      uvIndex: (daily['uv_index_max'][0] as num).toInt(),
      daylightDuration: (daily['daylight_duration'][0] as num).toDouble(),
      cloudCover: (current['cloud_cover'] as num).toInt(),
      dewPoint: (current['dew_point_2m'] as num).toDouble(),
      windDirection: (current['wind_direction_10m'] as num).toInt(),
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
  static String getWindDirectionText(int degrees) {
    if (degrees >= 337.5 || degrees < 22.5) return 'N';
    if (degrees < 67.5) return 'NE';
    if (degrees < 112.5) return 'E';
    if (degrees < 157.5) return 'SE';
    if (degrees < 202.5) return 'S';
    if (degrees < 247.5) return 'SW';
    if (degrees < 292.5) return 'W';
    return 'NW';
  }
}