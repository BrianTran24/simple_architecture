import 'package:flutter/material.dart';

ThemeData lightModeTheme = ThemeData(
  // fontFamily: 'SVN-Gilroy',
  colorScheme: const ColorScheme.dark(surface: Colors.black, primary: Colors.white),
  buttonTheme: const ButtonThemeData(height: 1.0),
  appBarTheme: const AppBarTheme(
    centerTitle: true
  ),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      fontSize: 10,
      height: 12 / 10,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 14.4 / 12,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 16.8 / 14,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      height: 19.2 / 16,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    // header1
    displayMedium: TextStyle(
      fontSize: 16,
      height: 19.2 / 16,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    // header2
    displaySmall: TextStyle(
      fontSize: 20,
      height: 24 / 20,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      height: 26,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      height: 28,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      height: 34 / 28,
      leadingDistribution: TextLeadingDistribution.even,
    ),
  ),
);
