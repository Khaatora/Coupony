import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
            HexColor("#00AF87"),
        ),
        foregroundColor: const MaterialStatePropertyAll<Color>(
          Colors.white,
        ),
      ),
    ),
    textTheme: TextTheme(
        displaySmall: TextStyle(
            fontSize: 16,
            color: HexColor("#00AF87"),
        ),
        displayMedium: TextStyle(
            fontSize: 24,
            color: HexColor("#00AF87"),
        )
    ),
  );
  static final dark = ThemeData(useMaterial3: true);
}
