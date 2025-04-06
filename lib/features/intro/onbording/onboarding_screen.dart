import 'package:meditech/features/intro/onbording/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/image_strings.dart';
import '../../../core/style/app_color.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // Build page indicators
  List<Widget> _buildPageIndicator() {
    return List.generate(
      _numPages,
      (index) => _indicator(index == _currentPage),
    );
  }

  // Indicator widget
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : AppColor.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.secondaryColor,
                AppColor.primaryColor,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Skip button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => print('Skip'),
                    child: Text(
                      'تخطي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),

                // PageView content
                Expanded(
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() => _currentPage = page);
                    },
                    children: [
                      _buildOnboardingPage(
                        image: AppImages.onboarding1,
                        title: 'فريق طبي متكامل',
                        subtitle:
                            'بشهادة عملاءنا، فريقنا الطبي يقوم على رعاية شاملة ومستمرة قبل وأثناء وبعد العملية بما يضمن راحتك التامة.',
                      ),
                      _buildOnboardingPage(
                        image: AppImages.onboarding2,
                        title: 'المتابعة المستمرة',
                        subtitle:
                            'دائماً متواجدون للرد على كافة استفساراتك والمتابعة الشخصية من دكتور عبد الرازق محمد.',
                      ),
                      _buildOnboardingPage(
                        image: AppImages.onboarding3,
                        title: 'إقامة فندقية',
                        subtitle:
                            'يضمن لك مركز دكتور عبد الرازق محمد أفضل المستشفيات للعملية والحصول على رعاية كاملة وراحة تامة قبل وأثناء وبعد العملية.',
                      ),
                    ],
                  ),
                ),

                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),

                // Next or Get Started button
                if (_currentPage != _numPages - 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.arrow_forward, size: 30.0),
                        label: const Text(
                          'التالي',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomePage(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 30.0,
                        ),
                      ),
                      child: const Text(
                        'ابدأ الآن',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build onboarding pages
  Widget _buildOnboardingPage({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              image,
              height: 300.0,
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 300.0,
            ),
          ),
          const SizedBox(height: 60.0),
          Text(
            title,
            style: kTitleStyle,
          ),
          const SizedBox(height: 20.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: kSubtitleStyle,
          ),
        ],
      ),
    );
  }
}

// Styles
final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 36.0,
  fontWeight: FontWeight.bold,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  height: 1.2,
);
