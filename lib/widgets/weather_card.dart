import 'package:boishakhi/models/weather_model.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    bool isNight = weather.timestamp.hour < 6 || weather.timestamp.hour >= 18;

    String getWeatherType(String main){
      final m = main.trim();
      if(isNight){
        if(m == 'Clear') return 'Clear_Night';
        if(m== 'Cloudy'){
          return 'Clouds_Night';
        }
        if(m == 'Partly Cloudy' || m.contains('Partly')){
          return 'Partly_Cloudy_Night';
        }
      }
      //Daytime
      if(main == 'Partly Cloudy') return 'Partly_Cloudy';
      if(main == 'Cloudy' || m.contains('Cloud')) return 'Clouds';
      if(main == 'Fog') return 'Atmosphere';
      return m;
    }

    String toSentenceCase(String text){
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1).toLowerCase();
    }

    final type = getWeatherType(weather.weatherMain);

    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatDate(weather.timestamp),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Text(
                toSentenceCase(weather.description),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '${weather.temperature.toStringAsFixed(0)}°C',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
          Image.asset(
            'assets/images/weather_icons/$type.png',
            width: 80,
            height: 50,
            colorBlendMode: BlendMode.srcIn,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
