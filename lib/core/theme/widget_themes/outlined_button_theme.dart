import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.backgroundLight,
      side: const BorderSide(color:  WhiteColors.grey),
      textStyle:  TextStyle(fontSize:  TSizes.fontSizeMd, color: AppColors.black, fontWeight: FontWeight.w600),
      padding:  EdgeInsets.symmetric(vertical: TSizes.buttonHeight, horizontal: TSizes.lg24),
      shape: RoundedRectangleBorder(side: BorderSide(color: WhiteColors.grey),
          borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),

  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.backgroundDark,
      side: const BorderSide(color: AppColors.borderPrimary),
      textStyle:  TextStyle(fontSize:  TSizes.fontSizeMd, color: AppColors.textWhite, fontWeight: FontWeight.w600),
      padding:  EdgeInsets.symmetric(vertical: TSizes.buttonHeight, horizontal: TSizes.lg24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),
  );
}
