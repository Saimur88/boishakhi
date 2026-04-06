import 'package:boishakhi/models/forecast_model.dart';
import 'package:boishakhi/widgets/forecast_tab_bar.dart';
import 'package:boishakhi/widgets/search_sheet.dart';
import 'package:boishakhi/widgets/sun_times_row.dart';
import 'package:boishakhi/widgets/temperature_graph.dart';
import 'package:boishakhi/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/stats_row.dart';
import 'package:boishakhi/widgets/forecast_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _forecastTabNotifier.dispose();
    super.dispose();
  }

  final ValueNotifier<int> _forecastTabNotifier = ValueNotifier(0);

  List<ForecastModel> _getFilteredForecast(
    List<ForecastModel> forecast,
    int tabIndex,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final fourDaysLater = today.add(const Duration(days: 4));

    switch (tabIndex) {
      case 0:
        return forecast
            .where(
              (f) =>
                  f.time.year == today.year &&
                  f.time.month == today.month &&
                  f.time.day == today.day,
            )
            .toList();
      case 1:
        return forecast
            .where(
              (f) =>
                  f.time.year == tomorrow.year &&
                  f.time.month == tomorrow.month &&
                  f.time.day == tomorrow.day,
            )
            .toList();
      case 2:
        return forecast
            .where(
              (f) => f.time.isAfter(tomorrow) && f.time.isBefore(fourDaysLater),
            )
            .toList();
        default:
        return forecast;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Boishakhi - ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text('The voice of Sky', style: TextStyle(fontSize: 14)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/menu.png', width: 20),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(
        context,
      ).colorScheme.surface.withValues(alpha: 0.6),
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.errorMessage != null
            ? Center(child: Text(provider.errorMessage!))
            : _buildBody(context, provider),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WeatherProvider provider) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, provider),
          const SizedBox(height: 24),
          if (provider.weather != null) WeatherCard(weather: provider.weather!),
          const SizedBox(height: 16),
          if (provider.weather != null)
            StatsRow(weather: provider.weather!, forecast: provider.forecast!),
          const SizedBox(height: 16),
          if (provider.weather != null) SunTimesRow(weather: provider.weather!),
          const SizedBox(height: 16),
          ForecastTabBar(tabNotifier: _forecastTabNotifier),
          const SizedBox(height: 16),
          if (provider.weather != null)
            ValueListenableBuilder(
              valueListenable: _forecastTabNotifier,
              builder: (context, tabIndex, _) {
                final filtered = _getFilteredForecast(provider.forecast!, tabIndex);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ForecastRow(
                      forecast: filtered,
                      forecastTabIndex: tabIndex,
                    ),
                    const SizedBox(height: 4),
                    if (provider.weather != null)
                      TemperatureGraph(
                        forecast: filtered,
                        forecastTabIndex: tabIndex,
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WeatherProvider provider) {
    final cityName = provider.weather?.cityName ?? 'Loading...';

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      splashColor: Theme.of(
        context,
      ).colorScheme.onSurface.withValues(alpha: 0.4),
      focusColor: null,
      onTap: () => _showSearchDialog(context),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withAlpha(120),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on_outlined, size: 24),

              Flexible(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final textspan = TextSpan(
                      text: cityName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                    final textpainter = TextPainter(
                      text: textspan,
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                    )..layout();

                    final isOverflow = textpainter.width > constraints.maxWidth;

                    return isOverflow
                        ? SizedBox(
                            height: 30,
                            child: Marquee(
                              text: cityName,
                              style: Theme.of(context).textTheme.headlineMedium,
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              blankSpace: 40.0,
                              velocity: 30.0,
                              pauseAfterRound: const Duration(seconds: 1),
                              startPadding: 0.0,
                              accelerationDuration: const Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: const Duration(
                                milliseconds: 500,
                              ),
                              decelerationCurve: Curves.easeOut,
                            ),
                          )
                        : Text(
                            cityName,
                            style: Theme.of(context).textTheme.headlineMedium,
                          );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.keyboard_double_arrow_down_rounded),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => const SearchSheet(),
    );
  }
}
