import 'package:boishakhi/providers/weather_provider.dart';
import 'package:boishakhi/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSheet extends StatefulWidget {
  const SearchSheet({super.key});

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _service = WeatherService();
  List<String> _suggestions = [];
  bool _isSearcing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSearchChanged(String query) async {
    if (query.length < 2) {
      setState(() {
        _suggestions = [];
      });
      return;
    }
    setState(() {
      _isSearcing = true;
    });
    final results = await _service.getCitySuggestions(query);
    setState(() {
      _suggestions = results;
      _isSearcing = false;
    });
  }

  void _selecCity(String city, BuildContext context) {
    final cityName = city.split(',')[0].trim();
    context.read<WeatherProvider>().fetchWeather(cityName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: scheme.onSurface.withAlpha(2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          //Title
          Text(
            'Search Location',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          //Gps button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<WeatherProvider>().fetchWeatherByLocation();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.my_location),
              label: const Text('use current location'),
            ),
          ),
          const SizedBox(height: 16),

          //Search Bar
          TextField(
            controller: _controller,
            autofocus: true,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search city...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _isSearcing
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 8),

          //Suggestions
          if (_suggestions.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(_suggestions[index]),
                  onTap: () => _selecCity(_suggestions[index], context),
                );
              },
            ),
        ],
      ),
    );
  }
}
