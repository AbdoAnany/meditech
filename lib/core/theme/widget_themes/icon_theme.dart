import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TIconTheme {
  TIconTheme._();

  static IconThemeData lightIconTheme =
      IconThemeData(color: AppColors.black, size: TSizes.iconMd);
  static IconThemeData darkIconTheme =
      IconThemeData(color: AppColors.white, size: TSizes.iconMd);
}
