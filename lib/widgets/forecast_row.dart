import 'package:boishakhi/models/forecast_model.dart';
import 'package:flutter/material.dart';

class ForecastRow extends StatelessWidget {
  final List<ForecastModel> forecast;

  const ForecastRow({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    String getWeatherType(int code, DateTime time) {
      bool isNight = time.hour < 6 || time.hour >= 18;

      if (code == 0) return isNight ? 'Clear_Night' : 'Clear';
      if (code == 1 || code == 2) {
        return isNight ? 'Partly_Cloudy_Night' : 'Partly_Cloudy';
      }
      if (code == 3) return isNight ? 'Clouds_Night' : 'Clouds';
      if (code <= 48) return 'Atmosphere';
      if (code <= 55) return 'Drizzle';
      if (code <= 65) return 'Rain';
      if (code <= 75) return 'Snow';
      if (code <= 82) return 'Rain';
      return 'Thunderstorm';
    }

    return SizedBox(
      height: 130,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: forecast.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = forecast[index];
          final type = getWeatherType(item.weatherCode, item.time);
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 90,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: scheme.surface.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(24),
              ),
              child: _forecastItem(
                context,
                type,
                _formatUnixTime(forecast[index].time),
                forecast[index].rainChances,
                forecast[index].temperature,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _forecastItem(
    BuildContext context,
    String type,
    String time,
    int rainChances,
    double temp,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          time.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        rainChances >= 20
            ? SizedBox.shrink()
            : type == 'Rain'
            ? Text(
                'Possible Rain',
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800),
              )
            : const SizedBox.shrink(),

        Image.asset(
          rainChances >= 20
              ? _getRainChanceIcon(rainChances)
              : 'assets/images/weather_icons/$type.png',
          width: 20,
          height: 20,
          colorBlendMode: BlendMode.srcIn,
        ),
        const SizedBox(height: 8),
        Text(
          '${temp.toStringAsFixed(0)}°C',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  String _formatUnixTime(DateTime time) {
    final now = DateTime.now();
    final isToday = time.day == now.day && time.month == now.month;
    final hour = time.hour;
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12
        ? hour - 12
        : hour == 0
        ? 12
        : hour;
    if (isToday) {
      return '$hour12 $period';
    } else {
      return '${_getWeekDay(time)} \n$hour12 $period';
    }
  }

  String _getRainChanceIcon(int rainChances) {
    if (rainChances >= 50 && rainChances <= 70) {
      return 'assets/images/weather_icons/Rain.png';
    } else if (rainChances >= 20 && rainChances <= 50) {
      return 'assets/images/weather_icons/Drizzle.png';
    } else {
      return 'assets/images/weather_icons/Thunderstorm.png';
    }
  }

  String _getWeekDay(DateTime time) {
    switch (time.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
        case 3:
        return 'Wed';
        case 4:
        return 'Thu';
        case 5:
        return 'Fri';
        case 6:
        return 'Sat';
        case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
