import 'package:boishakhi/models/forecast_model.dart';
import 'package:boishakhi/models/weather_model.dart';
import 'package:flutter/material.dart';
class StatsRow extends StatelessWidget {
  final WeatherModel weather;
  final List<ForecastModel> forecast;
  const StatsRow({super.key,required this.weather,required this.forecast});


  @override
  Widget build(BuildContext context) {

    final daylightSeconds = weather.daylightDuration.toInt();
    final daylightHours = daylightSeconds ~/ 3600;
    final daylightMinutes = (daylightSeconds % 3600) ~/ 60;

    final visibility = '${weather.visibility / 1000}';
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(24)
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem(context, 'Rain_Chance', '${weather.maxRainChance}%', 'Rain Chance'),
              _divider(scheme),
              _statItem(context, 'Cloud_Cover', '${weather.cloudCover}%', 'Cloud Cover'),
              _divider(scheme),
              _statItem(context, 'Wind_Direction', WeatherModel.getWindDirectionText(weather.windDirection), 'Wind Direction'),
              _divider(scheme),
              _statItem(context, 'Daylight_Duration', '$daylightHours : $daylightMinutes', 'Daylight Duration'),
              _divider(scheme),
              _statItem(context, 'UV_Index', '${weather.uvIndex}', 'UV Index'),
              _divider(scheme),
              _statItem(context, 'Dew_Point', '${weather.dewPoint.round()}°C', 'Dew Point'),
              _divider(scheme),
              _statItem(context, 'Visibility', '$visibility km', 'Visibility',),
            ],
          ),
      ),
    );
  }
  Widget _divider(ColorScheme scheme){
    return Container(
      width: 1,
      height: 40,
      color: scheme.onSurface.withValues(alpha: 0.1),
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
  Widget _statItem(BuildContext context, String image, String value,String label){
    return Column(
      children: [
        Image.asset('assets/images/weather_icons/$image.png', width: 24,),
        const SizedBox(height: 8),
        Text(value,style: TextStyle(
          fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w700
        )),
        Text(label,style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700
        ),),
      ],
    );
  }
}
