import 'package:boishakhi/models/weather_model.dart';
import 'package:flutter/material.dart';
class StatsRow extends StatelessWidget {
  final WeatherModel weather;
  const StatsRow({super.key,required this.weather});


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
          _statItem(context, Icons.air, '${weather.windSpeed} m/s', 'Wind',Colors.blueGrey),
          _divider(scheme),
          _statItem(context, Icons.water_drop_outlined, '${weather.humidity}%', 'Humidity',Colors.blue),
          _divider(scheme),
          _statItem(context, Icons.visibility, '${weather.visibility / 1000} km', 'Visibility',Colors.lightGreen),
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
  Widget _statItem(BuildContext context, IconData icon, String value,String label, Color color){
    return Column(
      children: [
        Icon(icon,size: 20,color: color,),
        const SizedBox(height: 8),
        Text(value,style: Theme.of(context).textTheme.titleMedium,),
        Text(label,style: Theme.of(context).textTheme.bodySmall,),
      ],
    );
  }
}
