import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/theme/style.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Icon(
            Iconsax.search_normal,
            color: Theme.of(context).iconTheme.color,
          ),
          hintText: "ابحث عن معامل الأشعة والتحاليل",
          hintStyle: MyFontStyles.greyRegular14,
          suffixIcon: Icon(
            Iconsax.setting_44,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
