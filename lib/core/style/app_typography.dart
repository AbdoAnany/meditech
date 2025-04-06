import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTypography {
  // Font Family
  static const String fontFamily = 'Poppins';

  // Title
  static TextStyle title = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
    color: AppColor.black,
  );

  // Heading-1
  static TextStyle heading1SemiBold = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600, // Semi-bold
    color: AppColor.black,
  );

  static TextStyle heading1Medium = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w500, // Medium
    color: AppColor.black,
  );

  static TextStyle heading1Regular = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400, // Regular
    color: AppColor.black,
  );

  // Heading-2
  static TextStyle heading2SemiBold = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600, // Semi-bold
    color: AppColor.black,
  );

  static TextStyle heading2Medium = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium
    color: AppColor.black,
  );

  static TextStyle heading2Regular = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    color: AppColor.black,
  );

  // Heading-3
  static TextStyle heading3Medium = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    color: AppColor.black,
  );

  // Paragraph-1
  static TextStyle paragraph1 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    color: AppColor.textColor,
  );

  // Paragraph-2
  static TextStyle paragraph2 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    color: AppColor.textColor,
  );

  // Body-1
  static TextStyle body1 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    color: AppColor.textColor,
  );

  // Body-2
  static TextStyle body2 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    color: AppColor.textColor,
  );

  // Body-3
  static TextStyle body3 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    color: AppColor.textColor,
  );
}

class AppLayout {
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const int gridColumns = 6;
  static const double gridMargin = 20.0;
  static const double gridGutter = 16.0;
}