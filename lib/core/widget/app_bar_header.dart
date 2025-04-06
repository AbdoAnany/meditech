
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../style/app_style.dart';

class AppBarHeader extends StatelessWidget  implements PreferredSizeWidget {
  AppBarHeader({super.key,
    this.centerTitle = true,
    this.title = "",});

  bool centerTitle = true;
  String title = "";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.lightGrey,
      title: Text(title, style: AppStyle.fWhiteS20W800,),
      centerTitle: centerTitle,

    );
  }

  PreferredSizeWidget buildBottomBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: SizedBox(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}