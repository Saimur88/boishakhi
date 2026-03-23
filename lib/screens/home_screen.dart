import 'package:boishakhi/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/stats_row.dart';

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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeader(context, provider), const SizedBox(height: 24),
          if(provider.weather != null)
          WeatherCard(weather: provider.weather!),
          const SizedBox(height: 24),
          if(provider.weather != null)
          StatsRow(weather: provider.weather!),

        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WeatherProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome to,', style: Theme.of(context).textTheme.bodyMedium),
            Text(
              provider.weather?.cityName ?? 'Boishakhi',style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
        IconButton(onPressed: ()=> _showSearchDialog(context), icon: Icon(Icons.search),)
      ],
    );
  }
  void _showSearchDialog(BuildContext context){
    showDialog(context: context,
        builder: (_) => AlertDialog(
          title: const Text('Search City'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
                hintText: 'e.g. Dhaka'),
            autofocus: true,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context),
                child: Text('Cancel')),
            TextButton(onPressed: (){
              final city =_controller.text.trim();
              if(city.isNotEmpty){
                context.read<WeatherProvider>().fetchWeather(city);
                Navigator.pop(context);
              }
            }, child: const Text('Search'))
          ],
        ));

  }
}


