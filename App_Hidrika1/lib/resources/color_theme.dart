import 'package:carrito_compras/resources/colors.dart';
import 'package:flutter/material.dart';

class ColorTheme {
  static final _kColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    primary: AppColors.primaryColor,
    surface: AppColors.backgroundColor, // background
  );

  static final _kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(1, 1, 1, 1),
  );

  static ThemeData fetchColorScheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _kColorScheme,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: AppBarTheme(
        backgroundColor: _kColorScheme.primary,
        titleTextStyle: const TextStyle(
          color: AppColors.headlineColor,
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme().copyWith(
        titleMedium: const TextStyle(
          color: AppColors.headlineColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        titleLarge: const TextStyle(
          color: AppColors.headlineColor,
          fontSize: 32,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  static ThemeData fetchDarkColorScheme() {
    return ThemeData(useMaterial3: true).copyWith(
      colorScheme: _kDarkColorScheme,
      scaffoldBackgroundColor: AppColors.headlineColor,
      appBarTheme: AppBarTheme(
        backgroundColor: _kDarkColorScheme.secondary,
        titleTextStyle: TextStyle(
          color: _kDarkColorScheme.surface,
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme().copyWith(
        titleMedium: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        titleLarge: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 32,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
