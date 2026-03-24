import 'package:boishakhi/services/weather_service.dart';
import 'package:flutter/material.dart';

import '../models/forecast_model.dart';
import '../models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _service = WeatherService();
  WeatherModel? _weather;
  List<ForecastModel>? _forecast;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ForecastModel>? get forecast => _forecast;


Future<void> fetchWeather(String city) async {
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();
  try{
    _weather = await _service.getWeatherByCity(city);
    _forecast = await _service.getForecast(city);
  }catch(e){
    _errorMessage = e.toString();
  }finally{
    _isLoading = false;
    notifyListeners();
  }
}


}