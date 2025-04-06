import 'package:meditech/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/widget_themes/appbar_theme.dart';
import '../../core/theme/widget_themes/bottom_sheet_theme.dart';
import '../../core/theme/widget_themes/checkbox_theme.dart';
import '../../core/theme/widget_themes/chip_theme.dart';
import '../../core/theme/widget_themes/elevated_button_theme.dart';
import '../../core/theme/widget_themes/icon_button_theme.dart';
import '../../core/theme/widget_themes/icon_theme.dart';
import '../../core/theme/widget_themes/outlined_button_theme.dart';
import '../../core/theme/widget_themes/text_field_theme.dart';
import '../../core/theme/widget_themes/text_theme.dart';
import '../constants/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    
    fontFamily: MyFontStyles.primaryFontFamily,
    disabledColor: AppColors.grey,

  //  brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
    chipTheme: TChipTheme.lightChipTheme,
    iconButtonTheme: TIconButtonTheme.lightIconButtonTheme,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    iconTheme: TIconTheme.lightIconTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: MyFontStyles.primaryFontFamily,
    disabledColor: AppColors.grey,
 //   brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    iconTheme: TIconTheme.darkIconTheme,
    iconButtonTheme: TIconButtonTheme.darkIconButtonTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool isDarkModeEnabled = true;
  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    bool isDark;
    isDark = mode == ThemeMode.dark;
    // sl<SharedPreferences>().setBool('isDark', isDark);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    // bool isDark = sl<SharedPreferences>().getBool('isDark') ?? false;
    // isDarkModeEnabled = isDark;
 return   _themeMode = ThemeMode.light;

  }  bool getThemeModeIsDark() {
    // bool isDark = sl<SharedPreferences>().getBool('isDark') ?? false;
    // isDarkModeEnabled = isDark;
 return   false;

  }
}
