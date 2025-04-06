import 'package:meditech/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app.dart';

class CustomFontWeight {
  static const FontWeight tajawalThin = FontWeight.w900;
  static const FontWeight tajawalExtraBold = FontWeight.w800;
  static const FontWeight tajawalBold = FontWeight.w700;
  static const FontWeight tajawalExtraLight = FontWeight.w200;
  static const FontWeight tajawalLight = FontWeight.w300;
  static const FontWeight tajawalRegular = FontWeight.w500;
  static const FontWeight tajawalMedium = FontWeight.w600;
}

class MyFontStyles {
  static const String primaryFontFamily = 'Tajawal';
  static const String secondaryFontFamily = 'Tajawal';

  static TextStyle primaryBold24 = TextStyle(
    fontFamily: primaryFontFamily,
    color: AppColors.primary,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 24.w,
  );
  static TextStyle greyBold24 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 24.w,
  );
  static TextStyle? blackBold24 = appTextTheme.headlineSmall;
  static TextStyle? blackBold20 = appTextTheme.headlineSmall?.copyWith(fontSize: 20.sp);

  // TextStyle(
  //   fontFamily: primaryFontFamily,
  //   color:,
  //
  //   fontWeight: CustomFontWeight.tajawalBold,
  //   fontSize: 24.w,
  // );

  static TextStyle grey2Bold18 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 18.w,
  );

  static TextStyle greySemiBold18 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalMedium,
    fontSize: 18.w,
  );

  static TextStyle greySemiBold16 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalMedium,
    fontSize: 16.w,
  );
  static TextStyle whiteSemiBold16 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.white,
    fontWeight: CustomFontWeight.tajawalMedium,
    fontSize: 16.w,
  );
  static TextStyle primarySemiBold16 = TextStyle(
    fontFamily: primaryFontFamily,
    color: AppColors.primary,
    fontWeight: CustomFontWeight.tajawalMedium,
    fontSize: 16.w,
  );

  static TextStyle? greyMedium18 = appTextTheme.titleMedium;

  // TextStyle(
  //   fontFamily: primaryFontFamily,
  //   fontWeight: CustomFontWeight.tajawalRegular,
  //   color: WhiteColors.textDarkGrey,
  //   fontSize: 18.w,
  // );

  static TextStyle blackBold14 = TextStyle(
    fontFamily: primaryFontFamily,
    color: BlueColors.dark,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 14.w,
  );  static TextStyle blackBold12 = TextStyle(
    fontFamily: primaryFontFamily,
    color: BlueColors.dark,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 14.w,
  );

  static TextStyle greyRegular18 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalRegular,
    fontSize: 18.w,
  );

  static TextStyle greyRegular15 = TextStyle(
    fontFamily: primaryFontFamily,
    fontWeight: CustomFontWeight.tajawalRegular,
    color: WhiteColors.textDarkGrey,
    fontSize: 15.w,
  );

  static TextStyle greyRegular14 = TextStyle(
    fontFamily: primaryFontFamily,
    fontWeight: CustomFontWeight.tajawalRegular,
    color: WhiteColors.textDarkGrey,
    fontSize: 14.w,
  );

  static TextStyle primaryBold14 = TextStyle(
    fontFamily: primaryFontFamily,
    fontWeight: CustomFontWeight.tajawalBold,
    color: AppColors.primary,
    fontSize: 14.w,
  );

  static TextStyle primaryRegular14 = TextStyle(
    fontFamily: primaryFontFamily,
    fontWeight: CustomFontWeight.tajawalRegular,
    color: AppColors.primary,
    fontSize: 14.w,
  );
}

class InputStyles {
  static const String primaryFontFamily = 'Tajawal';
  static const String secondaryFontFamily = 'Tajawal';

  static TextStyle primaryBold24 = TextStyle(
    fontFamily: primaryFontFamily,
    color: AppColors.primary,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 24.w,
  );
  static TextStyle greyBold24 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 24.w,
  );
  static TextStyle blackBold24 = TextStyle(
    fontFamily: primaryFontFamily,
    color: BlueColors.darkActive,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 24.w,
  );

  static TextStyle grey2Bold18 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 18.w,
  );

  static TextStyle greySemiBold18 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalMedium,
    fontSize: 18.w,
  );

  static TextStyle greySemiBold16 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalMedium,
    fontSize: 16.w,
  );
  static TextStyle whiteSemiBold16 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.white,
    fontWeight: CustomFontWeight.tajawalMedium,
    fontSize: 16.w,
  );
  static TextStyle primarySemiBold16 = TextStyle(
    fontFamily: primaryFontFamily,
    color: AppColors.primary,
    fontWeight: CustomFontWeight.tajawalMedium,
    fontSize: 16.w,
  );

  static TextStyle greyMedium18 = TextStyle(
    fontFamily: primaryFontFamily,
    fontWeight: CustomFontWeight.tajawalRegular,
    color: WhiteColors.textDarkGrey,
    fontSize: 18.w,
  );

  static TextStyle blackBold14 = TextStyle(
    fontFamily: primaryFontFamily,
    color: BlueColors.dark,
    fontWeight: CustomFontWeight.tajawalBold,
    fontSize: 14.w,
  );

  static TextStyle greyRegular18 = TextStyle(
    fontFamily: primaryFontFamily,
    color: WhiteColors.textDarkGrey,
    fontWeight: CustomFontWeight.tajawalRegular,
    fontSize: 18.w,
  );

  static TextStyle greyRegular15 = TextStyle(
    fontFamily: primaryFontFamily,
    fontWeight: CustomFontWeight.tajawalRegular,
    color: WhiteColors.textDarkGrey,
    fontSize: 15.w,
  );
  static TextStyle greyRegular14 = TextStyle(
    fontFamily: primaryFontFamily,
    fontWeight: CustomFontWeight.tajawalRegular,
    color: WhiteColors.textDarkGrey,
    fontSize: 14.w,
  );
}
