import 'package:boishakhi/models/weather_model.dart';
import 'package:flutter/material.dart';

class SunTimesRow extends StatelessWidget {
  final WeatherModel weather;
  const SunTimesRow({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _sunItem(
            context,
            time: weather.sunrise,
            label: 'Sunrise',
          ),
          Container(
            width: 1,
            height: 40,
            color: scheme.onSurface.withValues(alpha: 0.1),
          ),
          _sunItem(
            context,
            time: weather.sunset,
            label: 'Sunset',
          ),
        ],
      ),
    );
  }

  Widget _sunItem(
    BuildContext context, {
    required String time,
    required String label,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/sun_times/$label.png', width: 50),
        const SizedBox(width: 10,),

        Column(
          children: [
            Text(time, style: Theme.of(context).textTheme.titleMedium),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),

      ],
    );
  }
}
