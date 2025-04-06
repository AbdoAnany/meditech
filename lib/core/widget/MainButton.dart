

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class MainButton extends StatelessWidget {
   MainButton({super.key,this.onPressed,this.title=''});
   void Function()? onPressed;
   String? title;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 60.h,
      width: 398.w,
      // margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),//EdgeInsets.all(16),
      padding:EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:onPressed==null?Color(0xFF92A5B5): AppColors.primary
      ),
      //  width: MediaQuery.of(context).size.width * .9,
      //   height: TSizes.buttonHeight,
      child: TextButton(
          onPressed: onPressed,

          child:  Text('$title',style:
          GoogleFonts.ibmPlexSansArabic(
            color: Colors.white,
            fontSize: 16.sp,
            // fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.w700,
            height: 0.09,
          ),
            //    TextStyle(color: Colors.white),
          )),
    );
  }
}


class MainButtonOutLine extends StatelessWidget {
  MainButtonOutLine({super.key,this.onPressed,this.title=''});
  void Function()? onPressed;
  String? title;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 56.h,
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding:EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withOpacity(.3)),
          color: AppColors.primary.withOpacity(.07)
      ),
      //  width: MediaQuery.of(context).size.width * .9,
      //   height: TSizes.buttonHeight,
      child: TextButton(
          onPressed: onPressed,

          child:  Text('$title',style:
          TextStyle(
            color: Colors.white,
            fontSize: 16,

            fontWeight: FontWeight.w700,
            height: 0.09,
          ),
            //    TextStyle(color: Colors.white),
          )),
    );
  }
}
