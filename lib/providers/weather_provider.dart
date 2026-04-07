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
  String? _errorMessage;

  bool _isInitialLoading = true;
  bool get isInitialLoading => _isInitialLoading;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;


  WeatherModel? get weather => _weather;
  String? get errorMessage => _errorMessage;
  List<ForecastModel>? get forecast => _forecast;

  Future<void> fetchWeatherByLocation() async {
    _isInitialLoading = true;
    _isRefreshing = false;
    _errorMessage = null;
    notifyListeners();
    try {
      final location = await _locationService.getCurrentLocationWithCoords();
      if(location != null){
        _weather = await _service.getWeatherByCoordinates(
          location['lat'] as double,
          location['lon'] as double,
          location['name'] as String,
        );
        _forecast = await _service.getForecast(
          location['lat'] as double,
          location['lon'] as double,
        );
      }
      else{
        _errorMessage =  'Location permission denied';
      }
    }catch (e){
      _errorMessage = e.toString();
    }finally{
      _isInitialLoading = false;
      notifyListeners();
    }
  }
  Future<void> fetchWeatherWithCoordinates(
      double lat, double lon, String cityName) async {
    _errorMessage = null;
    notifyListeners();
    try {
      _weather = await _service.getWeatherByCoordinates(lat, lon, cityName);
      _forecast = await _service.getForecast(_weather!.lat, _weather!.lon);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> refresh()async{
    if(_weather == null){
      await fetchWeatherByLocation();
      return;
    }
    _isRefreshing = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await  fetchWeatherWithCoordinates(
        _weather!.lat,
        _weather!.lon,
        _weather!.cityName,
      );
    }finally{
      _isRefreshing = false;
      notifyListeners();
    }
  }


}