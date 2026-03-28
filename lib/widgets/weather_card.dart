import 'package:boishakhi/models/weather_model.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    bool isNight = weather.icon.endsWith('n');

    String getWeatherType(String main){
      const atmosphere = [
        'Mist',
        'Smoke',
        'Haze',
        'Dust',
        'Fog',
        'Sand',
        'Ash',
        'Squall',
        'Tornado',
      ];
      if(isNight && (main == 'Clear' || main == 'Clouds')) {
        return '${main}_Night';
      }
      return atmosphere.contains(main) ? 'Atmosphere' : main;
    }

    final type = getWeatherType(weather.weatherMain);

    return Container(
      width: double.infinity,
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
                weather.weatherMain,
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
