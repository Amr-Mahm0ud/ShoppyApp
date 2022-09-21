import 'package:flutter/material.dart';

const Color primaryClr = Color(0xFFFD692E);
const Color secondaryClr = Color(0xFF7577CD);
const Color backGLight = Color(0xFFFFFFFF);
const Color backGDark = Color(0xFF232528);
const Color cardDark = Color(0xFF2F3641);
const Color cardLight = Color(0xFFEFEDF0);
const Color success = Color(0xFF2BCF3C);
const Color error = Color(0xFFDA2121);

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryClr,
    backgroundColor: backGLight,
    splashColor: cardLight,
    brightness: Brightness.light,
    scaffoldBackgroundColor: backGLight,
    cardColor: cardLight,
    appBarTheme: const AppBarTheme(
        elevation: 0, foregroundColor: backGDark, color: backGLight),
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryClr,
      secondary: secondaryClr,
      error: error,
      tertiary: success,
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: primaryClr,
    backgroundColor: backGDark,
    splashColor: cardLight,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backGDark,
    cardColor: cardDark,
    appBarTheme: const AppBarTheme(
        elevation: 0, foregroundColor: backGLight, color: backGDark),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryClr,
      secondary: secondaryClr,
      error: error,
      tertiary: success,
    ),
  );
}
