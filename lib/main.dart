import 'package:boishakhi/app/theme/app_theme.dart';
import 'package:boishakhi/providers/weather_provider.dart';
import 'package:boishakhi/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>  WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        title: 'Boishakhi',
        home: HomeScreen(),
      ),
    );
  }
}
