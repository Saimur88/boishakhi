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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome to',style: TextStyle(fontSize: 12),),
            const Text('Boishakhi',style: TextStyle(fontSize: 16),),
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeader(context, provider), const SizedBox(height: 24),
          if(provider.weather != null)
          WeatherCard(weather: provider.weather!),
          const SizedBox(height: 16),
          if(provider.weather != null)
          StatsRow(weather: provider.weather!),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,size: 18,),
              Text(
                provider.weather?.cityName ?? 'Boishakhi'
                ,style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
        ),
        IconButton(onPressed: ()=> _showSearchDialog(context), icon: Icon(Icons.search),)
      ],
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


