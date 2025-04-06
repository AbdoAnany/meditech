import 'package:meditech/features/0-intro/presentation/pages/SplashScreen.dart';
import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../features/0-intro/presentation/pages/OnboardingView.dart';

class IntroScreen extends StatefulWidget {
  static const String onBoarding = 'onBoarding';
  const IntroScreen({super.key});
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool onBoardingShow = true;
  @override
  void initState() {
    appTextTheme=   Theme.of(Get.context).textTheme;

    //  onBoardingShow = sl<SharedPreferences>().getBool(IntroScreen.onBoarding) ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: onBoardingShow ? const OnBoardingView() : const SplashScreen(),
    );
  }
}
