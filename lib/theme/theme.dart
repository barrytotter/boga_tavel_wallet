import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 89, 89, 89),
  colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 238, 219, 55)),
  dividerColor: Colors.white10,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Color.fromARGB(255, 89, 89, 89),
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white.withValues(alpha: 0.6),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
);
