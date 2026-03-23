import 'dart:convert';

import 'package:boishakhi/models/weather_model.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class WeatherService {
  static const _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> getWeatherByCity(String city) async {
    final url = Uri.parse(
      '$_baseUrl?q=$city&appid=${Config.apiKey}&units=metric'
    );
    final response = await http.get(url);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return WeatherModel.fromJson(json);
    }
    else {
      throw Exception('Failed to load weather data');
    }

  }
}