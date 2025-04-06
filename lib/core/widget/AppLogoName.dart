import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/image_strings.dart';

class AppLogoName extends StatelessWidget {
  AppLogoName({super.key, this.isLightTheme = false});
  final bool isLightTheme;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isLightTheme ? AppImages.logoWithName : AppImages.logoName,
      width: 112.w,
      height: 58.h,
    );
  }
}
