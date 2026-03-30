import 'dart:convert';
import 'package:boishakhi/models/forecast_model.dart';
import 'package:boishakhi/models/weather_model.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class WeatherService {
  static const _baseUrl = 'https://api.open-meteo.com/v1/forecast';
  static const _geoUrl = 'https://geocoding-api.open-meteo.com/v1/search';

  Future<WeatherModel> getWeatherByCity(String city) async {

    final coords = await _getCityCoordinates(city);
    if(coords == null) throw Exception('City not found');

    return getWeatherByCoordinates(
      coords['lat']!,
      coords['lon']!,
      coords['name']!,
    );
    }

  Future<Map<String, dynamic>?> _getCityCoordinates(String city) async {
    final url = Uri.parse(
        '$_geoUrl?name=$city&count=1&language=en'
    );
    final response = await http.get(url);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      if(json['results'] == null || json['results'].isEmpty) return null;
      final result = json['results'][0];
      return {
        'name': result['name'] as String,
        'lat': result['latitude'] as double,
        'lon': result['longitude'] as double,
      };
    }
    return null;
  }


  Future<WeatherModel> getWeatherByCoordinates(double lat, double lon, String cityName) async {
    final url = Uri.parse(
      '$_baseUrl?latitude=$lat&longitude=$lon'
          '&current=temperature_2m,relative_humidity_2m,apparent_temperature,'
          'weather_code,wind_speed_10m,visibility'
          '&daily=sunrise,sunset'
          '&timezone=auto',
    );
    final response = await http.get(url);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return WeatherModel.fromJson(json, cityName);
    }else{
      throw Exception('Failed to load weather data');
    }
  }



  Future<List<String>> getCitySuggestions(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse(
      'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=${Config.apiKey}',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) {
        final city = item['name'] as String;
        final country = item['country'] as String;
        final state = item['state'] as String? ?? '';
        return state.isNotEmpty
            ? '$city, $state $country'
            : '$city, $country';
      }).toList();
    }
    return [];
  }

  Future<List<ForecastModel>> getForecast(double lat, double lon) async {
    final url = Uri.parse(
      '$_baseUrl?latitude=$lat&longitude=$lon'
          '&hourly=temperature_2m,weather_code,precipitation_probability'
          '&timezone=auto&forecast_days=1',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ForecastModel.fromHourlyJson(json);
    } else {
      throw Exception('Forecast failed to load');
    }
  }


}
