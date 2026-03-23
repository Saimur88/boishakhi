class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherMain;
  final String description;
  final int sunrise;
  final int sunset;
  final double humidity;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherMain,
    required this.description,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      weatherMain: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: (json['main']['humidity'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}