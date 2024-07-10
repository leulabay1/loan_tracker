import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ThemeClass {
  static Color primarColor = const Color.fromRGBO(67, 118, 249, 1);
  static Color secondaryColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color backgroundColor = const Color.fromRGBO(40, 40, 40, 1);
  static Color secondaryColor2 = const Color.fromRGBO(45, 56, 84, 1);
  static Color error = Color.fromARGB(255, 255, 1, 1);
  static Color green = Color.fromARGB(255, 30, 188, 36);

  static Color darkBackgroundColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color darkSecondaryColor = const Color.fromRGBO(40, 40, 40, 1);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: darkBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primarColor,
      secondary: darkSecondaryColor,
      background: darkBackgroundColor,
      tertiary: secondaryColor2,
      error: error,
      scrim: green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => primarColor),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10));
            }),
            foregroundColor:
                MaterialStateProperty.all<Color>(darkSecondaryColor))),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.getFont('Outfit',
          fontSize: 5.w,
          fontWeight: FontWeight.normal,
          color: darkSecondaryColor),
      displayMedium: GoogleFonts.getFont('Outfit',
          fontSize: 4.5.w,
          fontWeight: FontWeight.normal,
          color: darkSecondaryColor),
      displaySmall: GoogleFonts.getFont('Outfit',
          fontSize: 4.w,
          fontWeight: FontWeight.normal,
          color: darkSecondaryColor),
      titleLarge: GoogleFonts.getFont('Outfit',
          fontSize: 7.w,
          fontWeight: FontWeight.bold,
          color: darkSecondaryColor),
      titleMedium: GoogleFonts.getFont('Outfit',
          fontSize: 3.5.w,
          fontWeight: FontWeight.bold,
          color: darkSecondaryColor),
      titleSmall: GoogleFonts.getFont('Outfit',
          fontSize: 3.w,
          fontWeight: FontWeight.bold,
          color: darkSecondaryColor),
      bodyLarge: GoogleFonts.getFont('Outfit',
          fontSize: 7.w, color: darkSecondaryColor),
      bodyMedium: GoogleFonts.getFont('Outfit',
          fontSize: 3.5.w, color: darkSecondaryColor),
      bodySmall: GoogleFonts.getFont('Outfit',
          fontSize: 3.w, color: darkSecondaryColor.withOpacity(0.4)),
    ),
    iconTheme: IconThemeData(
      color: darkSecondaryColor,
      size: 10.w,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primarColor,
      secondary: secondaryColor,
      background: backgroundColor,
      tertiary: secondaryColor2,
      error: error,
      scrim: green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => primarColor),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10));
            }),
            foregroundColor: MaterialStateProperty.all<Color>(secondaryColor))),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.getFont('Outfit',
          fontSize: 5.w, fontWeight: FontWeight.normal, color: secondaryColor),
      displayMedium: GoogleFonts.getFont('Outfit',
          fontSize: 4.5.w,
          fontWeight: FontWeight.normal,
          color: secondaryColor),
      displaySmall: GoogleFonts.getFont('Outfit',
          fontSize: 4.w, fontWeight: FontWeight.normal, color: secondaryColor),
      titleLarge: GoogleFonts.getFont('Outfit',
          fontSize: 7.w, fontWeight: FontWeight.bold, color: secondaryColor),
      titleMedium: GoogleFonts.getFont('Outfit',
          fontSize: 3.5.w, fontWeight: FontWeight.bold, color: secondaryColor),
      titleSmall: GoogleFonts.getFont('Outfit',
          fontSize: 3.w, fontWeight: FontWeight.bold, color: secondaryColor),
      bodyLarge:
          GoogleFonts.getFont('Outfit', fontSize: 7.w, color: secondaryColor),
      bodyMedium:
          GoogleFonts.getFont('Outfit', fontSize: 3.5.w, color: secondaryColor),
      bodySmall: GoogleFonts.getFont('Outfit',
          fontSize: 3.w, color: secondaryColor.withOpacity(0.4)),
    ),
    iconTheme: IconThemeData(
      color: secondaryColor,
      size: 10.w,
    ),
  );
}

ThemeClass _themeClass = ThemeClass();
