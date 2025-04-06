import 'package:meditech/core/constants/image_strings.dart';
import 'package:meditech/core/widget/AppLogoName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90.w,
        leading: Container(
          width: 55.w,
          height: 55.w,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFE7EBEF)),
              shape: BoxShape.circle),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Iconsax.arrow_right_14,
              color: Color(0xFF1D2035),
            ),
          ),
        ),
        title: AppLogoName(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.splashScreenImage1,
                    height: 200.h,
                  )),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
