import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/text_strings.dart';
import '../../../../core/widget/AppLogoName.dart';
import 'GifFadeToImageWidget.dart';
import 'OnBoardingItems.dart';

class FadeTransitionScreen extends StatefulWidget {
  @override
  _FadeTransitionScreenState createState() => _FadeTransitionScreenState();
}

class _FadeTransitionScreenState extends State<FadeTransitionScreen> {
  int currentIndex = 0;
  final controller = OnBoardingItems();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Column(
              key: ValueKey<int>(currentIndex),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -96.h,
                      left: -76.w,
                      right: -76.w,
                      child: Container(
                        width: 583.w,
                        height: 583.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Color(0xFFDCEAFF),
                          shape: BoxShape.circle,
                        ),
                        child: GifFadeToImageWidget(
                          gifPath: controller.items[currentIndex].image,
                          imagePath: controller.items[currentIndex].line,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                currentIndex = controller.items.length - 1;
                              });
                            },
                            child: Text(
                              '< ' + TTexts.skip,
                              style: TextStyle(
                                color: Color(0xFF7991A4),
                                fontSize: 16.w,
                                fontWeight: FontWeight.w700,
                                height: 0.09,
                              ),
                            ),
                          ),
                          Spacer(),
                          AppLogoName(),
                          Spacer(),
                          SizedBox(width: 60.w),
                          if (currentIndex > 0)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentIndex--;
                                });
                              },
                              child: Text(
                                TTexts.pre + " >",
                                style: TextStyle(
                                  color: Color(0xFF7991A4),
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w700,
                                  height: 0.09,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(height: 48.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    controller.items[currentIndex].title,
                    style: TextStyle(
                      fontSize: 24.w,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1D2035),
                      fontFamily: GoogleFonts.ibmPlexSansArabic().fontFamily,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.only(right: 42.w, left: 42.w),
                  child: Text(
                    controller.items[currentIndex].descriptions,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff637D92),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
        // Navigation buttons for Next and Previous
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentIndex > 0)
              TextButton(
                onPressed: () {
                  setState(() {
                    currentIndex--;
                  });
                },
                child: Text(
                  'Previous',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            if (currentIndex < controller.items.length - 1)
              TextButton(
                onPressed: () {
                  setState(() {
                    currentIndex++;
                  });
                },
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
