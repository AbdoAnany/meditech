import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.black, size: TSizes.iconMd),
    actionsIconTheme: IconThemeData(color: AppColors.black, size: TSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: TSizes.fontSizeLg,
        fontWeight: FontWeight.w600,
        color: AppColors.black),
  );
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.black, size: TSizes.iconMd),
    actionsIconTheme: IconThemeData(color: AppColors.white, size: TSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: TSizes.fontSizeLg,
        fontWeight: FontWeight.w600,
        color: AppColors.white),
  );
}
