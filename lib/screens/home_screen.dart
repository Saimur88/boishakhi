import 'package:boishakhi/widgets/search_sheet.dart';
import 'package:boishakhi/widgets/sun_times_row.dart';
import 'package:boishakhi/widgets/temperature_graph.dart';
import 'package:boishakhi/widgets/weather_card.dart';
import 'package:flutter/material.dart';
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
    super.dispose();
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
            Text('Boishakhi - ',style: Theme.of(context).textTheme.titleMedium),
            const Text('The voice of Sky',style: TextStyle(fontSize: 14),)

          ],
        ),
        actions: [
         Padding(
           padding: const EdgeInsets.only(right: 8),
           child: IconButton(onPressed: (){}, icon: Image.asset('assets/images/menu.png',width: 20,)),
         )
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
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
        children: [_buildHeader(context, provider), const SizedBox(height: 24),
          if(provider.weather != null)
          WeatherCard(weather: provider.weather!),
          const SizedBox(height: 16),
          if(provider.weather != null)
          StatsRow(weather: provider.weather!,forecast: provider.forecast!,),
          const SizedBox(height: 16),
          if(provider.weather != null)
            SunTimesRow(weather: provider.weather!),
          const SizedBox(height: 16),
          if(provider.weather != null)
          ForecastRow(forecast: provider.forecast!),
            const SizedBox(height: 16),
          if(provider.weather != null)
          TemperatureGraph(forecast: provider.forecast!),

        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WeatherProvider provider) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      splashColor: Theme.of(context).colorScheme.onSurface.withAlpha(50),
      focusColor: null,

      onTap: ()=> _showSearchDialog(context),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withAlpha(120),
              borderRadius: BorderRadius.circular(24)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on_outlined,size: 24,),
              Text(
                provider.weather!.cityName
                ,style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(width: 8),
              Icon(Icons.keyboard_double_arrow_down_rounded,)
            ],
          ),
        ),
      ),
    );
  }
  void _showSearchDialog(BuildContext context){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) => const SearchSheet());

  }
}


