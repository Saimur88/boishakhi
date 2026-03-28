import 'package:boishakhi/models/forecast_model.dart';
import 'package:boishakhi/models/weather_model.dart';
import 'package:flutter/material.dart';
class ForecastRow extends StatelessWidget {
  final List<ForecastModel> forecast;
  const ForecastRow({super.key,required this.forecast});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    bool isNight = forecast[0].icon.endsWith('n');
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

    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: forecast.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
          final item = forecast[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 95,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: _forecastItem(context, forecast[index].icon, _formatUnixTime(forecast[index].time), forecast[index].rainChances, forecast[index].temperature),
            ),
          );
          }),
    );
  }
  Widget _forecastItem(BuildContext context, String icon, String time,double rainChances,double temp){
    return Column(
      children: [
        Text(time.toString(),style: Theme.of(context).textTheme.titleMedium,),
        if(rainChances > 0) Text('${(rainChances * 100).toStringAsFixed(0)}%',style: Theme.of(context).textTheme.labelMedium,),
        Image.network('https://openweathermap.org/img/wn/$icon@2x.png',width: 40,height: 40,),
        Text('${temp.toStringAsFixed(0)}°C',style: Theme.of(context).textTheme.bodyLarge,),
      ],
    );
  }
  String _formatUnixTime(int unixTime) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    final hour = dateTime.hour;
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12
        ? hour - 12
        : hour == 0
        ? 12
        : hour;
    return '$hour12 $period';
  }
}
