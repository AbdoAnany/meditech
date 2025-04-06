import 'package:meditech/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/text_strings.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/widget/AppLogoName.dart';
import '../../../../core/widget/MainButton.dart';
import '../../../login/presentation/pages/LoginScreen.dart';
import '../widget/GifFadeToImageWidget.dart';
import '../widget/OnBoardingItems.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final controller = OnBoardingItems();
  final pageController = PageController();
  int currentIndex = 0;
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffFFFFFF),
      body: Column(
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
                        top: -80.h,
                        left: -76.w,
                        right: -76.w,
                        child: Container(
                          width: 583.w,
                          height: 583.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColors.primary0.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: GifFadeToImageWidget(
                            gifPath: controller.items[currentIndex].image,
                            imagePath: controller.items[currentIndex].line,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top

                            // 24.0.h
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                          SizedBox(width: 85.w
                            ,child:
                           currentIndex > 0?
                          TextButton(
                          onPressed: () {
            setState(() {
            currentIndex--;
            });
            },
              child: Text("< "+
                  TTexts.pre ,
                style: GoogleFonts.ibmPlexSansArabic(
                  color: Color(0xFF7991A4),
                  fontSize: 16.w,
                  fontWeight: FontWeight.w700,
                  height: 0.09,
                ),
              ),
            ):null
                            ,
                            ),

                            Spacer(),
                            AppLogoName(),
                            Spacer(),
                            SizedBox(width: 85.w
                              ,child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentIndex = controller.items.length - 1;
                                  });
                                },
                                child: Text(
                                   TTexts.skip+" >",
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: Color(0xFF7991A4),
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w700,
                                    height: 0.09,
                                  ),
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
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontSize: 22.w,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1D2035),
                        // fontFamily: GoogleFonts.ibmPlexSansArabic().fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38.w),
                    child: Text(
                      controller.items[currentIndex].descriptions,
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontSize: 16.sp,
                        // wordSpacing: 1,

                        fontWeight: FontWeight.w500,
                        color: Color(0xff637D92),
                        height: 1.5,
                      )

                      // TextStyle(
                      //
                      // )
                      ,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
          SmoothPageIndicator(
            controller: PageController(
              initialPage: currentIndex,
            ),
            count: 3,
            textDirection: TextDirection.rtl,
            axisDirection: Axis.horizontal,
            effect: CustomizableEffect(
              spacing: 13.0.w,
              dotDecoration: DotDecoration(
                  color:AppColors.primary0.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                  dotBorder: DotBorder(
                    color: AppColors.transparent,
                    padding: 6.0,
                    width: 2.0,
                  )),
              activeDotDecoration: DotDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8.0),
                  dotBorder: DotBorder(
                    color: AppColors.primary,
                    padding: 6.0,
                    width: 1.0,
                  )),
            ),
          ),
          SizedBox(height: 67.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:16.w,),
            child: MainButton(
              title: currentIndex == controller.items.length - 1
                  ? TTexts.start
                  : TTexts.next,
              onPressed: () async {
                // sl<SharedPreferences>()
                //     .setBool(IntroScreen.onBoarding, false);
                // if(!( currentIndex== controller.items.length - 1))
                currentIndex++;

                if (currentIndex == controller.items.length) {
                  currentIndex--;
                  THelperFunctions.navigateToScreen( LoginScreen());
                } else {
                  setState(() {});
                }
              },
            ),
          ),
          SizedBox(height: 19.h),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
