import 'package:boishakhi/app/theme/app_colors.dart';
import 'package:boishakhi/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        surface: AppColors.lightCard,
        onSurface: AppColors.lightText
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.temperature.copyWith(
          color: AppColors.lightText,
        ),
          headlineMedium: AppTextStyles.subHeading.copyWith(
            color: AppColors.lightText
          ),
        titleMedium: AppTextStyles.subHeading.copyWith(
          color: AppColors.lightSubText
        ),
        bodyMedium: AppTextStyles.caption.copyWith(
          color: AppColors.lightSubText
        )
      )
    );
  }
  static ThemeData get darkTheme{
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: const ColorScheme.dark(
            primary: AppColors.accent,
            surface: AppColors.darkCard,
            onSurface: AppColors.darkText
        ),
        textTheme: TextTheme(
            displayLarge: AppTextStyles.temperature.copyWith(
              color: AppColors.darkText,
            ),
            headlineMedium: AppTextStyles.subHeading.copyWith(
                color: AppColors.darkText
            ),
            titleMedium: AppTextStyles.subHeading.copyWith(
                color: AppColors.darkSubText
            ),
            bodyMedium: AppTextStyles.caption.copyWith(
                color: AppColors.darkSubText
            )
        )
    );
  }
}