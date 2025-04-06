import 'package:meditech/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppThemeColors {
  static bool isDarkMode = true;

  // Dark Theme Colors
  static const darkColors = ColorScheme(
    white: Colors.white,
    primary: Color(0xFF6200EE),
    green: Colors.green,
    textGray: Color(0xFF9E9E9E),
    textGray2: Color(0xFF757575),
    iconHomeColor: Color(0xFFBDBDBD),
    dotColor: Colors.pink,
    storeCard2: Color(0xFFFFD700),
    levelHomeColor: Color(0xFFFFD700),
    bgFiledColor: Color(0xFF424242),
  );

  // Light Theme Colors
  static const lightColors = ColorScheme(
    white: Colors.black,
    primary: Color(0xFF6200EE),
    green: Colors.green,
    textGray: Color(0xFF757575),
    textGray2: Color(0xFF9E9E9E),
    iconHomeColor: Color(0xFFBDBDBD),
    dotColor: Colors.pink,
    storeCard2: Color(0xFFFFD700),
    levelHomeColor: Color(0xFFFFD700),
    bgFiledColor: Color(0xFFF5F5F5),
  );

  static ColorScheme get current => isDarkMode ? darkColors : lightColors;
}

class ColorScheme {
  final Color white;
  final Color primary;
  final Color green;
  final Color textGray;
  final Color textGray2;
  final Color iconHomeColor;
  final Color dotColor;
  final Color storeCard2;
  final Color levelHomeColor;
  final Color bgFiledColor;

  const ColorScheme({
    required this.white,
    required this.primary,
    required this.green,
    required this.textGray,
    required this.textGray2,
    required this.iconHomeColor,
    required this.dotColor,
    required this.storeCard2,
    required this.levelHomeColor,
    required this.bgFiledColor,
  });
}
class AppStyle {
  // White text styles
  static TextStyle get fWhiteS30W700 => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 30.w);

  static TextStyle get fWhiteS21W700 => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w700,
      fontSize: 21.w);

  static TextStyle get fWhiteS18W700 => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 18.w);

  static TextStyle get fWhiteS14W700 => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w400,
      fontSize: 14.w);

  static TextStyle get fWhiteS14W400 => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w400,
      fontSize: 10.w);

  static TextStyle get fWhiteS21W700Quicksand => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 21.w);

  static TextStyle get fWhiteS48W400BebasNeue => TextStyle(
      color: AppColors.textPrimaryLight,
      fontFamily: "BebasNeue",
      fontWeight: FontWeight.w400,
      fontSize: 48.w);

  static TextStyle get fWhiteS21W400BebasNeue => TextStyle(
      color: AppColors.textPrimaryLight,
      fontFamily: "BebasNeue",
      fontWeight: FontWeight.w400,
      fontSize: 21.w);

  static TextStyle get fWhiteS12W400 => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w400,
      fontSize: 12.w);

  static TextStyle get fWhiteS16W800 => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w800,
      fontSize: 16.w);

  static TextStyle get fWhiteS18W800Quicksand => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w800,
      fontFamily: "Quicksand",
      fontSize: 18.w);

  static TextStyle get fWhiteS20W800 => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w800,
      fontSize: 20.w);

  static TextStyle get fWhiteS24W800BebasNeue => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w800,
      fontFamily: "BebasNeue",
      fontSize: 24.w);

  static TextStyle get fWhiteS28W400BebasNeue => TextStyle(
      color: AppColors.textPrimaryLight,
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
      fontFamily: "BebasNeue",
      fontSize: 28.w);

  // Colored text styles
  static TextStyle get textStyle12GreenW400 => TextStyle(
      color: AppThemeColors.current.green,
      fontWeight: FontWeight.w400,
      fontSize: 12.w);

  static TextStyle get textStyle14GrayW400 => TextStyle(
      color: AppThemeColors.current.textGray,
      fontWeight: FontWeight.w400,
      fontSize: 14.w);

  static TextStyle get textStyle15GreenW500 => TextStyle(
      color: AppThemeColors.current.green,
      fontWeight: FontWeight.w500,
      fontSize: 14.w);

  static TextStyle get textStyle14GreenW400 => TextStyle(
      color: AppThemeColors.current.green,
      fontWeight: FontWeight.w400,
      fontSize: 16.w);

  static TextStyle get textStyle14GrayerW400 => TextStyle(
      color: AppThemeColors.current.textGray2,
      fontWeight: FontWeight.w400,
      fontSize: 14.w);

  static TextStyle get textStyle10GrayW400 => TextStyle(
      color: AppThemeColors.current.textGray,
      fontWeight: FontWeight.w400,
      fontSize: 10.w);

  static TextStyle get textStyle8GrayW400 => TextStyle(
      color: AppThemeColors.current.textGray,
      fontWeight: FontWeight.w400,
      fontSize: 8.w);

  static TextStyle get textStyle14PrimaryW400 => TextStyle(
      color: AppThemeColors.current.primary,
      fontWeight: FontWeight.w400,
      fontSize: 14.w);

  static TextStyle get textStyle16PrimaryW400 => TextStyle(
      color: AppThemeColors.current.primary,
      fontWeight: FontWeight.w400,
      fontSize: 16.w);

  static TextStyle get textStyle12GrayW400 => TextStyle(
      color: AppThemeColors.current.textGray,
      fontWeight: FontWeight.w400,
      fontSize: 12.w);

  static TextStyle get textStyle12GrayLightW400 => TextStyle(
      color: AppThemeColors.current.iconHomeColor,
      fontWeight: FontWeight.w400,
      fontSize: 12.w);

  static TextStyle get textStyle12PinkW400 => TextStyle(
      color: AppThemeColors.current.dotColor,
      fontWeight: FontWeight.w400,
      fontSize: 12.w);

  static TextStyle get textStyle14PinkW400 => TextStyle(
      color: AppThemeColors.current.dotColor,
      fontWeight: FontWeight.w400,
      fontSize: 14.w);

  static TextStyle get textStyle28GGoldW800BebasNeue => TextStyle(
      color: AppThemeColors.current.storeCard2,
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
      fontFamily: "BebasNeue",
      fontSize: 28.w);

  static TextStyle get textStyle14GGoldW800BebasNeue => TextStyle(
      color: AppThemeColors.current.storeCard2,
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
      fontSize: 34.w);

  static TextStyle get textStyle20GoldW800 => TextStyle(
      color: AppThemeColors.current.levelHomeColor,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 20.w);

  static TextStyle get textStyle16GoldW800 => TextStyle(
      color: AppThemeColors.current.levelHomeColor,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 16.w);

  static BoxDecoration get decorationHome => BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
          color: AppThemeColors.current.white.withOpacity(.17)),
      color: AppThemeColors.current.white.withOpacity(.10));

  static InputDecoration inputDecoration({
    String hintText = '',
    void Function()? changeObscureText,
    obscureText = true,
  }) =>
      InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: AppThemeColors.current.textGray),
        fillColor: AppThemeColors.current.bgFiledColor,
        suffixIcon: hintText.contains("password")
            ? InkWell(
          child: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppThemeColors.current.primary,
          ),
        )
            : const SizedBox(height: 25),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppThemeColors.current.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppThemeColors.current.primary.withOpacity(.8)),
          borderRadius: BorderRadius.circular(10),
        ),
      );
}