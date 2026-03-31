import 'package:boishakhi/models/forecast_model.dart';
import 'package:flutter/material.dart';
class ForecastRow extends StatelessWidget {
  final List<ForecastModel> forecast;
  const ForecastRow({super.key,required this.forecast});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    String getWeatherType(int code, DateTime time){
      bool isNight = time.hour < 6 || time.hour >= 18;

      if (code == 0) return isNight ? 'Clear_Night' : 'Clear';
      if (code <= 2) return isNight ? 'Clouds_Night' : 'Partly_Cloudy';
      if (code == 3) return 'Clouds';
      if (code <= 48) return 'Atmosphere';
      if (code <= 55) return 'Drizzle';
      if (code <= 65) return 'Rain';
      if (code <= 75) return 'Snow';
      if (code <= 82) return 'Rain';
      return 'Thunderstorm';
    }



    return SizedBox(
      height: 140,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: forecast.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
          final item = forecast[index];
          final type = getWeatherType(item.weatherCode, item.time);
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 95,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: _forecastItem(context, type, _formatUnixTime(forecast[index].time), forecast[index].rainChances, forecast[index].temperature),
            ),
          );
          }),
    );
  }
  Widget _forecastItem(BuildContext context, String type, String time,int rainChances,double temp){
    print(time);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(time.toString(),style: Theme.of(context).textTheme.titleMedium,),
        rainChances >= 20 ? Text('$rainChances %',style: Theme.of(context).textTheme.labelMedium,) : type == 'Rain' ? Text('Possible Rain',style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800
        )) : const SizedBox(height: 8,),

        Image.asset(
          rainChances >= 20 ? _getRainChanceIcon(rainChances) :
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
    print(time);
    final hour = time.hour;
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12
        ? hour - 12
        : hour == 0
        ? 12
        : hour;
    return '$hour12 $period';
  }
  String _getRainChanceIcon(int rainChances){
    if(rainChances >=50 && rainChances <= 70){
      return 'assets/images/weather_icons/Rain.png';
    }
    else if (rainChances >= 20 && rainChances <= 50){
      return 'assets/images/weather_icons/Drizzle.png';
    } else{
      return 'assets/images/weather_icons/Thunderstorm.png';
    }
  }
}
