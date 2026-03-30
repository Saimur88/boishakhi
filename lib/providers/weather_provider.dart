import 'package:boishakhi/services/weather_service.dart';
import 'package:flutter/material.dart';

import '../models/forecast_model.dart';
import '../models/weather_model.dart';
import 'package:boishakhi/services/location_service.dart';



class WeatherProvider extends ChangeNotifier {
  WeatherProvider(){
    fetchWeatherByLocation();
  }

  final WeatherService _service = WeatherService();
  final LocationService _locationService = LocationService();

  WeatherModel? _weather;
  List<ForecastModel>? _forecast;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ForecastModel>? get forecast => _forecast;

  Future<void> fetchWeatherByLocation() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final city = await _locationService.getCurrentCity();
      if(city != null){
        _weather = await _service.getWeatherByCity(city);
        _forecast = await _service.getForecast(
          _weather!.lat,
          _weather!.lon,
        );
      }
      else{
        _errorMessage =  'Location permission denied';
      }
    }catch (e){
      _errorMessage = e.toString();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }


Future<void> fetchWeather(String city) async {
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();
  try{
    _weather = await _service.getWeatherByCity(city);
    _forecast = await _service.getForecast(_weather!.lat, _weather!.lon);
  }catch(e){
    _errorMessage = e.toString();
  }finally{
    _isLoading = false;
    notifyListeners();
  }
}


}