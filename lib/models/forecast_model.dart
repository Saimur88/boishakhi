class ForecastModel {
  final DateTime time;
  final double temperature;
  final String weatherMain;
  final String icon;

  ForecastModel({
    required this.time,
    required this.temperature,
    required this.weatherMain,
    required this.icon,
});
  factory ForecastModel.fromJson(Map<String, dynamic> json){
    return ForecastModel(
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temperature: (json['main']['temp'] as num).toDouble(),
        weatherMain: json['weather'][0]['main'],
        icon: json['weather'][0]['icon'],
    );
  }
}