import 'package:flutter/material.dart';

class AppColors {
  // App theme colors


  static MaterialColor primary0 = MaterialColor(0xFF009883, {
    50: Color(0xFFE6F6F4),
    100: Color(0xFFE6F6F4),
    200: Color(0xFFD9F2EF),
    300: Color(0xFFB0E4DD),
    400: Color(0xFF00A991),
    500: Color(0xFF009883),
    600: Color(0xFF008774),
    700: Color(0xFF007665),
    800: Color(0xFF006556),
    900: Color(0xFF004E3B),
  });

  static MaterialColor secondaryP = MaterialColor(0xFF006557, {
    50: Color(0xFFE6F6F4),
    100: Color(0xFF00CCAF),
    200: Color(0xFF00B299),
    300: Color(0xFF009983),
    400: Color(0xFF007F6D),
    500: Color(0xFF006557),
    600: Color(0xFF004C41),
    700: Color(0xFF00332C),
    800: Color(0xFF001916),
    900: Color(0xFF000000),
  });
  static MaterialColor grayBlueP = MaterialColor(0xFF47586E, {
    50: Color(0xFFB2BBC6),
    100: Color(0xFFB2BBC6),
    200: Color(0xFFA3ADBB),
    300: Color(0xFF909DAD),
    400: Color(0xFF546881),
    500: Color(0xFF47586E),
    600: Color(0xFF3D4C5E),
  });

  static MaterialColor grayP = MaterialColor(0xFF6D6D6D, {
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFD9D9D9),
    300: Color(0xFFB3B3B3),
    400: Color(0xFF8C8C8C),
    500: Color(0xFF6D6D6D),
    600: Color(0xFF404040),
  });


  static const Color primaryColor = Color(0xFF144DDE); // Deep blue

  static const Color primary = Color(0xFF007F6D);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color scaffoldBackgroundColor = Color(0xFFF5F5F5);
  static const  Color background =Color(0xffEEF1F6);
//
  // Text colors
  static const Color textPrimaryLight = Color(0xFF121212);
  static const Color textSecondary = Color(0xFF92A5B5);
  // Color(0xFF92A5B5)
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color backgroundDark = Color(0xFF1D242D);
  static const Color backgroundDarker = Color(0xFF161C22);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = AppColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF007F6D);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color blueWhite = Color(0xffEEF1F6);
  static const Color ofWhite = Color(0xfff3f3f3);
  static const Color transparent = Colors.transparent;



}


class WhiteColors {
  // White color variations
  static const Color tranperant = Color(0xFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteHover = Color(0xFFFCFDFD);
  static const Color whiteActive = Color(0xFFF5F7F9);

  // Light color variations
  static const Color light = Color(0xFFFCFDFD);
  static const Color lightHover = Color(0xFFF5F7F9);
  static const Color lightActive = Color(0xFFF0F3F6);

  // Normal color variations
  static const Color normal = Color(0xFFF9FAFB);
  static const Color normalHover = Color(0xFFF2F4F7);
  static const Color normalActive = Color(0xFFEBEEF2);

  // Dark color variations
  static const Color dark = Color(0xFFF6F8F9);
  // grey color variations
  static const Color grey = Color(0xFFA6A6A6);
  // grey color variations

  static const Color textDarkGrey = Color(0xFF8E8E8E);
  static const Color textDarkerGrey = Color(0xFF4E4E4E);
}
class BlueColors {
  // Lighter color variations
  static const Color lighter = Color(0xFFB2BBC6);
  static const Color lightHover = Color(0xFFA3ADBB);
  static const Color lightActive = Color(0xFF909DAD);

  // Normal color variations
  static const Color normal = Color(0xFF546881);
  static const Color normalHover = Color(0xFF47586E);
  static const Color normalActive = Color(0xFF3D4C5E);

  // Dark color variations
  static const Color dark = Color(0xFF1D242D);
  static const Color darkHover = Color(0xFF151A20);
  static const Color darkActive = Color(0xFF090B0E);
}

class GreenColors {
  // Light color variations
  static const Color light = Color(0xff0f7f7e);
  static const Color lightHover = Color(0xFFD9F2EF);
  static const Color lightActive = Color(0xFFB0E4DD);

  // Normal color variations
  static const Color normal = Color(0xFF00A991);
  static const Color normalHover = Color(0xFF009883);
  static const Color normalActive = Color(0xFF008774);

  // Dark color variations
  static const Color dark = Color(0xFF007F6D);
  static const Color darkHover = Color(0xFF006557);
  static const Color darkActive = Color(0xFF004C41);

  // Darker color variations
  static const Color darker = Color(0xFF003B33);
}
