  class ForecastModel {
    final DateTime time;
    final double temperature;
    final String weatherMain;
    final String icon;
    final double rainChances;

    ForecastModel({
      required this.time,
      required this.temperature,
      required this.weatherMain,
      required this.icon,
      required this.rainChances,
  });
    factory ForecastModel.fromJson(Map<String, dynamic> json){
      return ForecastModel(
          time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000).toLocal(),
          temperature: (json['main']['temp'] as num).toDouble(),
          weatherMain: json['weather'][0]['main'],
          rainChances: (json['pop'] as num).toDouble(),
          icon: json['weather'][0]['icon'],
      );
    }
  }