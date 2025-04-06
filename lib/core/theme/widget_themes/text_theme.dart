import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

/// Custom Class for Light & Dark Text Themes
class AppTextTheme {
  AppTextTheme(); // To avoid creating instances
  static TextStyle? displayLarge;
  static TextStyle? displayMedium;
  static TextStyle? displaySmall;

  static TextStyle? headlineLarge;
  static TextStyle? headlineMedium;
  static TextStyle? headlineSmall;

  static TextStyle? textBold24;
  static TextStyle? textNormal18;
  static TextStyle? titleMedium;
  static TextStyle? titleSmall;

  static TextStyle? bodyLarge;
  static TextStyle? bodyMedium;
  static TextStyle? bodySmall;

  static TextStyle? labelLarge;
  static TextStyle? labelMedium;
  static TextStyle? labelSmall;

  // static TextStyle? TextStyle? style =>
  //     theme.isDarkModeEnabled
  //         ?style
  //         :style;

  // static TextStyle? textStyleHandlerLight(TextStyle? style) => style?.copyWith(fontSize: style.fontSize, color: style.color);
  // static TextStyle? textStyleHandlerDark(TextStyle? style) => style?.copyWith(fontSize: style.fontSize, color: style.color);

  static init(context,isDark) {


    final textTheme = Theme.of(context).textTheme;



    displayLarge = textTheme.displayLarge; // 57.0
    displayMedium = textTheme.displayMedium; // 45.0
    displaySmall = textTheme.displaySmall; // 36.0

    headlineLarge =textTheme.headlineLarge; // 32.0
    headlineMedium = textTheme.headlineMedium; // 28.0
    headlineSmall = textTheme.headlineSmall; // 24.0

    textBold24 =  TextStyle(fontSize: 24.sp,
        color: isDark? AppColors.textPrimaryDark: AppColors.textPrimaryLight,
        fontWeight: FontWeight.bold);

    textNormal18 = TextStyle(fontSize: 18.sp,
        color: isDark?
        AppColors.textPrimaryDark:
        AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal);

    // 22.0
    titleMedium = textTheme.titleMedium; // 16.0
    titleSmall = textTheme.titleSmall; // 14.0

    bodyLarge = textTheme.bodyLarge; // 16.0
    bodyMedium = textTheme.bodyMedium; // 14.0
    bodySmall = textTheme.bodySmall; // 12.0

    labelLarge = textTheme.labelLarge; // 14.0
    labelMedium = textTheme.labelMedium; // 12.0
    labelSmall = textTheme.labelSmall; // 11.0

  }


  // static TextStyle? displayMedium = Theme.of(context1).textTheme.displayMedium;

  /// Customizable Light Text Theme
  /// The 2018 spec has thirteen text styles:
  ///
  /// | NAME           | SIZE |  WEIGHT |  SPACING |             |
  /// |----------------|------|---------|----------|-------------|
  /// | displayLarge   | 96.0 | light   | -1.5     |             |
  /// | displayMedium  | 60.0 | light   | -0.5     |             |
  /// | displaySmall   | 48.0 | regular |  0.0     |             |
  /// | headlineMedium | 34.0 | regular |  0.25    |             |
  /// | headlineSmall  | 24.0 | regular |  0.0     |             |
  /// | titleLarge     | 20.0 | medium  |  0.15    |             |
  /// | titleMedium    | 16.0 | regular |  0.15    |             |
  /// | titleSmall     | 14.0 | medium  |  0.1     |             |
  /// | bodyLarge      | 16.0 | regular |  0.5     |             |
  /// | bodyMedium     | 14.0 | regular |  0.25    |             |
  /// | bodySmall      | 12.0 | regular |  0.4     |             |
  /// | labelLarge     | 14.0 | medium  |  1.25    |             |
  /// | labelSmall     | 10.0 | regular |  1.5     |             |
  ///
  /// ...where "light" is `FontWeight.w300`, "regular" is `FontWeight.w400` and
  /// "medium" is `FontWeight.w500`.

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 50.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    displayMedium: TextStyle(fontSize: 46.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    displaySmall: TextStyle(fontSize: 42.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    headlineLarge:  TextStyle(fontSize: 36.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    headlineMedium: TextStyle(fontSize: 32.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    headlineSmall: TextStyle(fontSize: 28.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.bold),
    titleLarge:  TextStyle(fontSize: 24.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 22.sp,color:AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    titleSmall:   TextStyle(fontSize: 20.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    bodyLarge:   TextStyle(fontSize: 18.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    bodyMedium:  TextStyle(fontSize: 16.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    bodySmall:   TextStyle(fontSize: 14.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    labelLarge:   TextStyle(fontSize: 12.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    labelMedium: TextStyle(fontSize: 10.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
    labelSmall:   TextStyle(fontSize: 8.sp,color: AppColors.textPrimaryLight,
        fontWeight: FontWeight.normal),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 50.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    displayMedium: TextStyle(fontSize: 46.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    displaySmall: TextStyle(fontSize: 42.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    headlineLarge:  TextStyle(fontSize: 36.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    headlineMedium: TextStyle(fontSize: 32.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    headlineSmall: TextStyle(fontSize: 28.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.bold),
    titleLarge:  TextStyle(fontSize: 24.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 22.sp,color:AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    titleSmall:   TextStyle(fontSize: 20.sp,color: AppColors.textSecondary,
        fontWeight: FontWeight.normal),
    bodyLarge:   TextStyle(fontSize: 18.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    bodyMedium:  TextStyle(fontSize: 16.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    bodySmall:   TextStyle(fontSize: 14.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    labelLarge:   TextStyle(fontSize: 12.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    labelMedium: TextStyle(fontSize: 10.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
    labelSmall:   TextStyle(fontSize: 8.sp,color: AppColors.textPrimaryDark,
        fontWeight: FontWeight.normal),
  );
}
