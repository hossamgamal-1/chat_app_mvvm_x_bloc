import 'package:flutter/material.dart';

class ThemesManager {
  static ThemeData getLightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,

      // appBarTheme:
      // buttonTheme:
      // cardTheme:
    );
  }
  /*  return ThemeData(
      primarySwatch: Colors.blue,
      canvasColor: const Color(0xff5B5DEF),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff5B5DEF),
        onPrimary: Colors.transparent,
        secondary: Color(0xff3AE4DF),
        onSecondary: Colors.transparent,
        error: Colors.red,
        onError: Colors.transparent,
        background: Color(0xff5B5DEF),
        onBackground: Colors.transparent,
        surface: Colors.transparent,
        onSurface: Colors.transparent,
      ),
    );
   */
}
