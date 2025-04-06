




import 'package:meditech/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../di.dart';
import '../theme/theme.dart';
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
extension TextThemeReFactor on TextTheme {
  TextStyle headlineSmall() {
    


    return TextStyle(
      fontWeight: FontWeight.bold,
      color: get_it<ThemeProvider>().isDarkModeEnabled
          ? AppColors.textPrimaryDark
          : AppColors.textPrimaryLight,
      fontSize: 24.sp,
    );
  }
}

// extension Scaffold on Scaffold {
//   Scaffold scaffold({required Widget body}) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: GestureDetector(
//           onTap: () {
//             FocusManager.instance.primaryFocus?.unfocus();
//           },
//          
//           child: body),
//     );
//   }
// }