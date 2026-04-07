import 'package:boishakhi/models/forecast_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureGraph extends StatelessWidget {
  final List<ForecastModel> forecast;
  const TemperatureGraph({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final scheme = Theme.of(context).colorScheme;

    final spots = forecast.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.temperature);
    }).toList();

    return Container(
      width: double.infinity,
      height: 170,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => scheme.surface,
              getTooltipItems: (touchSpots) {
                return touchSpots.map((spot) {
                  final index = spot.x.toInt();
                  final time = forecast[index].time;
                  final hour = time.hour;
                  final date = time.day;
                  final month = months[time.month - 1];
                  final period = hour >= 12 ? 'PM' : 'AM';
                  final hour12 = hour > 12
                      ? hour - 12
                      : hour == 0
                      ? 12
                      : hour;
                  return LineTooltipItem(
                    '$date\t$month\t$hour12 $period\n${spot.y.toStringAsFixed(0)}°C',
                    const TextStyle(color: Colors.white, fontSize: 12),
                  );
                }).toList();
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= forecast.length) {
                    return SizedBox.shrink();
                  }
                  final time = forecast[index].time;
                  final hour = time.hour;
                  final period = hour >= 12 ? 'PM' : 'AM';
                  final hour12 = hour > 12
                      ? hour - 12
                      : hour == 0
                      ? 12
                      : hour;
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '$hour12 $period',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: scheme.primary,
              barWidth: 2,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                      radius: 4,
                      color: scheme.primary,
                      strokeWidth: 0,
                    ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    scheme.primary.withAlpha(100),
                    scheme.primary.withAlpha(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
