import 'package:boishakhi/app/theme/app_colors.dart';
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
            icon: Icons.wb_twighlight,
            iconColor: AppColors.sunriseColor,
            time: _formatUnixTime(weather.sunrise),
            label: 'Sunrise',
          ),
          Container(
            width: 1,
            height: 40,
            color: scheme.onSurface.withValues(alpha: 0.1),
          ),
          _sunItem(
            context,
            icon: Icons.nights_stay_outlined,
            iconColor: AppColors.sunsetColor,
            time: _formatUnixTime(weather.sunset),
            label: 'Sunset',
          ),
        ],
      ),
    );
  }

  Widget _sunItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String time,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 28, color: iconColor),
        const SizedBox(height: 8),
        Text(time, style: Theme.of(context).textTheme.titleMedium),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  String _formatUnixTime(int unixTime) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12
        ? hour - 12
        : hour == 0
        ? 12
        : hour;
    return '$hour12:$minute$period';
  }
}
