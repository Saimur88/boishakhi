import 'package:boishakhi/models/forecast_model.dart';
import 'package:boishakhi/models/weather_model.dart';
import 'package:flutter/material.dart';
class StatsRow extends StatelessWidget {
  final WeatherModel weather;
  final List<ForecastModel> forecast;
  const StatsRow({super.key,required this.weather,required this.forecast});


  @override
  Widget build(BuildContext context) {
    final visibility = '${weather.visibility / 1000}';
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: scheme.surface,
          borderRadius: BorderRadius.circular(24)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statItem(context, 'Temp', '${weather.feelsLike.toStringAsFixed(0)}°C', 'Feels Like'),
          _divider(scheme),
          _statItem(context, 'Humidity', '${weather.humidity}%', 'Humidity'),
          _divider(scheme),
          _statItem(context, 'Drizzle', '${forecast[0].rainChances.toStringAsFixed(1)}%', 'Rain Chance'),
          _divider(scheme),
          Column(
            children: [
              _statItem(context, 'Wind', '${weather.windSpeed} m/s', 'Wind'),
            ],
          ),

        ],
      ),
    );
  }
  Widget _divider(ColorScheme scheme){
    return Container(
      width: 1,
      height: 40,
      color: scheme.onSurface.withValues(alpha: 0.1),
    );
  }
  Widget _statItem(BuildContext context, String image, String value,String label){
    return Column(
      children: [
        Image.asset('assets/images/weather_icons/$image.png', width: 24,),
        const SizedBox(height: 8),
        Text(value,style: Theme.of(context).textTheme.titleMedium,),
        Text(label,style: Theme.of(context).textTheme.bodySmall,),
      ],
    );
  }
}
