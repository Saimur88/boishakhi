import 'package:flutter/material.dart';

class AppTextStyles {
  //Large Temp
  static final TextStyle temperature = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w500

  );

  // City name, screen title
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  // Weather type: "Cloudy", "Sunny"
  static const TextStyle subHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  // Date, small labels
  static const TextStyle body = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  // Wind, Humidity labels
  static const TextStyle caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
}