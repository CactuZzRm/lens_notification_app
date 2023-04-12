import 'package:flutter/material.dart';

class ThemesCatalog {
  ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(15, 14, 24, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(23, 21, 41, 1),
          elevation: 0.8,
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            color: Color.fromRGBO(95, 98, 119, 1),
          ),
          bodyMedium: TextStyle(
            color: Color.fromRGBO(203, 207, 235, 1),
          ),
          bodyLarge: TextStyle(
            color: Color.fromRGBO(222, 223, 255, 1),
          ),
        ),
      );

  ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(235, 235, 235, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(245, 245, 245, 1),
          elevation: 0.8,
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            color: Color.fromRGBO(164, 166, 186, 1),
          ),
          bodyMedium: TextStyle(
            color: Color.fromRGBO(37, 29, 90, 1),
          ),
          bodyLarge: TextStyle(
            color: Color.fromRGBO(43, 42, 98, 1),
          ),
        ),
      );
}
