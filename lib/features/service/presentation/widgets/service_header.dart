

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditech/core/constants/colors.dart';

class ServiceHeader extends StatelessWidget {
  const ServiceHeader({super.key,
    required this.title,
    required this.onSeeMoreTap,
  });
  final String title;
  final VoidCallback onSeeMoreTap;
  @override
  Widget build(BuildContext context) {
    return
       Row(
        children: [
          Text(
            title,
            style: GoogleFonts.ibmPlexSansArabic(
              color:   AppColors.primary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onSeeMoreTap,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                "المزيد",
                style: GoogleFonts.ibmPlexSansArabic(
                  color: AppColors.primary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    }


}
