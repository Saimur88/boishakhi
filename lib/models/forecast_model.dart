  class ForecastModel {
    final DateTime time;
    final double temperature;
    final int weatherCode;
    final int rainChances;

    ForecastModel({
      required this.time,
      required this.temperature,
      required this.weatherCode,
      required this.rainChances,
  });

    static List<ForecastModel> fromHourlyJson (Map<String, dynamic> json){
      final hourly = json['hourly'];
      final times = hourly['time'] as List;
      final temps = hourly['temperature_2m'] as List;
      final codes = hourly['weather_code'] as List;
      final rain = hourly['precipitation_probability'] as List;
      final now = DateTime.now();
      return List.generate(times.length, (i){
        return ForecastModel(
            time: DateTime.parse(times[i]),
            temperature: (temps[i] as num).toDouble(),
            weatherCode: codes[i] as int,
            rainChances: rain[i] as int,
        );
      }).where((f) => f.time.isAfter(now)).take(24).toList();
    }
  }