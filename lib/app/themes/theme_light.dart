import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surfaceContainer: Color.fromRGBO(255, 255, 255, 1),
    surface: Color.fromRGBO(248, 248, 255, 1),
    secondary: Color.fromRGBO(169, 169, 169, 1),
    tertiary: Color.fromRGBO(105, 105, 105, 1),
    primary: Color.fromRGBO(43, 52, 147, 1),
    primaryContainer: Color.fromRGBO(44, 58, 122, 1),

    onPrimary: Color.fromRGBO(255, 255, 255, 1),
    onSurface: Color.fromRGBO(0, 0, 0, 1),
    onSecondary: Color.fromRGBO(21, 23, 41, 1),
    onTertiary: Color.fromRGBO(34, 41, 82, 1),
    onPrimaryContainer: Color.fromRGBO(43, 52, 147, 1),
  ),

  // FadeUpwardsPageTransitionsBuilder
  // OpenUpwardsPageTransitionsBuilder
  // ZoomPageTransitionsBuilder
  // CupertinoPageTransitionsBuilder
  // pageTransitionsTheme: const PageTransitionsTheme(
  //   builders: {
  //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  //   },
  // ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
);