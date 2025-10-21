import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surfaceContainer: Color.fromRGBO(0, 0, 0, 1),
    surface: Color.fromRGBO(31, 31, 31, 1),
    secondary: Color.fromRGBO(48, 48, 48, 1),
    tertiary: Color.fromRGBO(71, 71, 71, 1),
    primary: Color.fromRGBO(43, 52, 147, 1),
    primaryContainer: Color.fromRGBO(44, 58, 122, 1),

    onPrimary: Color.fromRGBO(255, 255, 255, 1),
    onSurface: Color.fromRGBO(248, 248, 255, 1),
    onSecondary: Color.fromRGBO(211, 211, 211, 1),
    onTertiary: Color.fromRGBO(169, 169, 169, 1),
    onPrimaryContainer: Color.fromRGBO(169, 169, 169, 1),
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