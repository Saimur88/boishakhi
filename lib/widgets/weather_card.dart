import 'package:boishakhi/models/weather_model.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    bool isNight = weather.timestamp.hour < 7 || weather.timestamp.hour >= 18;

    String getWeatherType(String main){
      final m = main.trim();
      if(isNight){
        if(m== 'Cloudy'){
          return 'Cloudy_Night';
        }
        if(m == 'Partly Cloudy' || m.contains('Partly')){
          return 'Partly_Cloudy_Night';
        }
        if(m == 'Drizzle' || m.contains('Drizzle')){
          return 'Drizzle_Night';
        }
        if(m == 'Rain' || m.contains('Rain')){
          return 'Rainy_Night';
        }
        if(m == 'Snow' || m.contains('Snow')){
          return 'Snowy_Night';
        }
        return 'Clear_Night';
      }
      //Daytime
      if(main == 'Partly Cloudy') return 'Partly_Cloudy';
      if(main == 'Cloudy' || m.contains('Cloud')) return 'Cloudy';
      if(main == 'Fog') return 'Atmosphere';
      if(main == 'Snow' || m.contains('Snow')) return 'Snow';
      if(main == 'Drizzle' || m.contains('Drizzle')) return 'Drizzle';
      if(main == 'Rain' || m.contains('Rain')) return 'Rainy';
      if(main == 'Thunderstorm' || m.contains('Thunderstorm')) return 'Thunderstorm';
      if(main == 'Clear') return 'Clear';


      return m;
    }

    String toSentenceCase(String text){
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1).toLowerCase();
    }

    final type = getWeatherType(weather.weatherMain);

    return Container(
      width: double.infinity,
      // height: 170,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/weather_card_background/$type.png'),
            opacity: 0.3,
            fit: BoxFit.cover),
        //color: scheme.surface,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              scheme.primary.withAlpha(100),
              scheme.primary.withAlpha(0),
            ]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _formatDate(weather.timestamp),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),

              Text(
                '${weather.temperature.round()}°C',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),

              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.arrow_upward,size: 16,),
                  Text('${weather.highestTemp.round()}°C',),
                  const SizedBox(width: 8,),
                  Icon(Icons.arrow_downward,size: 16,),
                  Text('${weather.lowestTemp.round()}°C',
)
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //const SizedBox(height: 50),
              Text(
                toSentenceCase(weather.description),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.wind_power,size: 16,),
                  Text('${weather.windSpeed.toStringAsFixed(1)} m/s',
                      style: TextStyle(
                          fontSize: 12,
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w700
                      )),
                  const SizedBox(width: 8,),
                  Icon(Icons.water_drop_outlined,size: 16,),
                  Text('${weather.humidity.toStringAsFixed(1)}%',
                      style: TextStyle(
                          fontSize: 12,
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w700
                      )),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text('Feels Like', style: Theme.of(context).textTheme.titleSmall,),
                  Text(' ${weather.feelsLike.toStringAsFixed(0)}°C',
                    style: Theme.of(context).textTheme.titleSmall,),
                  Icon(Icons.thermostat_outlined,size: 16,color: weather.feelsLike > 25 ? scheme.error : scheme.primary,),
                ],
              )

            ],
          )
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
