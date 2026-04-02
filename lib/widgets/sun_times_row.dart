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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _sunItem(
            context,
            time: weather.sunrise,
            label: 'Sunrise',
          ),
          _divider(scheme),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('assets/images/sun_times/$label.png', width: 40),
        const SizedBox(width: 10,),
        Column(
          children: [
            Text(time, style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            )),
            Text(label, style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700
            )),
          ],
        ),

      ],
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
}
