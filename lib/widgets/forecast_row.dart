import 'package:boishakhi/models/forecast_model.dart';
import 'package:flutter/material.dart';
class ForecastRow extends StatelessWidget {
  final List<ForecastModel> forecast;
  const ForecastRow({super.key,required this.forecast});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    String getWeatherType(String main, String icon){
      bool isNight = icon.endsWith('n');
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
      height: 140,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: forecast.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
          final item = forecast[index];
          final type = getWeatherType(item.weatherMain, item.icon);
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 95,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: _forecastItem(context, type, forecast[index].icon, _formatUnixTime(forecast[index].time), forecast[index].rainChances, forecast[index].temperature),
            ),
          );
          }),
    );
  }
  Widget _forecastItem(BuildContext context, String type, String icon, String time,double rainChances,double temp){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(time.toString(),style: Theme.of(context).textTheme.titleMedium,),
        rainChances > 0 ? Text('${(rainChances * 100).toStringAsFixed(0)}%',style: Theme.of(context).textTheme.labelMedium,) : const SizedBox(height: 8,),

        Image.asset(
          rainChances > 0 ? _getRainChanceIcon(rainChances * 100) :
          'assets/images/weather_icons/$type.png',
          width: 20,
          height: 20,
          colorBlendMode: BlendMode.srcIn,
        ),
        const SizedBox(height: 8,),
        Text('${temp.toStringAsFixed(0)}°C',style: Theme.of(context).textTheme.bodyLarge,),
      ],
    );
  }
  String _formatUnixTime(DateTime time) {
    final hour = time.hour;
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12
        ? hour - 12
        : hour == 0
        ? 12
        : hour;
    return '$hour12 $period';
  }
  String _getRainChanceIcon(double rainChances){
    if(rainChances < 50){
      return 'assets/images/weather_icons/Drizzle.png';
    }
    else if (rainChances >=50 && rainChances < 70){
      return 'assets/images/weather_icons/Rain.png';
    }
    else{
      return 'assets/images/weather_icons/Thunderstorm.png';
    }
  }
}
