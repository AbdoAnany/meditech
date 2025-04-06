import 'package:meditech/core/constants/StringKeys.dart';
import 'package:meditech/core/local_storage/storage_utility.dart';
import 'package:meditech/features/0-intro/presentation/pages/OnboardingView.dart';
import 'package:meditech/features/1-login/presentation/pages/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app.dart';
import '../../../../core/Enums.dart';
import '../../../../core/animation/Animation.dart';
import '../../../../core/constants/Global.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../home/presentation/pages/home_screen.dart';
// import '../../../home/presentation/pages/Home.dart';
// import '../../../../auth/helper/AppRoutes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    AnimationHelper.fadeInOut(this);
    appTextTheme = Theme.of(Get.context).textTheme;
    TLocalStorage _storage = TLocalStorage();

    _storage.getAllKeys().then((value) {
      print('All keys: $value');
    });

    final bool isOnBoarding =
        _storage.readData<bool>(StringKeys.onBoarding) ?? true;
    final _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out! isOnBoarding ${isOnBoarding}');

        if (isOnBoarding) {
          _storage.saveData<bool>(StringKeys.onBoarding, false);
          THelperFunctions.navigateAndReplaceScreen(OnBoardingView());
        } else {
          THelperFunctions.navigateAndReplaceScreen(LoginScreen());
        }
      } else {
        Global.userDate = await TLocalStorage.getCacheUser();
        print('User is signed in! ${Global.userDate?.toMap()}');
        if (Global.userDate?.userType == UserRole.patient.name) {
          // FirebaseMessaging.instance.subscribeToTopic('admins_topic');
          //  FirebaseMessaging.instance.subscribeToTopic('doctors_topic');
          FirebaseMessaging.instance
              .subscribeToTopic('patients_topic_${Global.userDate?.phone}');
        }
        if (Global.userDate?.userType == UserRole.doctor.name) {
          // FirebaseMessaging.instance.subscribeToTopic('admins_topic');
          //  FirebaseMessaging.instance.subscribeToTopic('doctors_topic');
          // FirebaseMessaging.instance.subscribeToTopic('patients_topic_${Global.userDate?.phone}');
          FirebaseMessaging.instance.subscribeToTopic('doctors_topic');
        }
        FirebaseMessaging.instance.subscribeToTopic('all_topic');
        // FirebaseMessaging.instance.subscribeToTopic('patients_topic');
        // FirebaseMessaging.instance.subscribeToTopic('nurses_topic');
        // FirebaseMessaging.instance.subscribeToTopic('pharmacists_topic');
        // FirebaseMessaging.instance.subscribeToTopic('receptionists_topic');
        // FirebaseMessaging.instance.subscribeToTopic('admins_topic');
        // FirebaseMessaging.instance.subscribeToTopic('lab_technicians_topic');
        // FirebaseMessaging.instance.subscribeToTopic('radiologists_topic');
        // FirebaseMessaging.instance.subscribeToTopic('accountants_topic');
        // FirebaseMessaging.instance.subscribeToTopic('managers_topic');
        // FirebaseMessaging.instance.subscribeToTopic('secretaries_topic');
        // FirebaseMessaging.instance.subscribeToTopic('nurses_topic');
        // FirebaseMessaging.instance.subscribeToTopic('pharmacists_topic');
        // FirebaseMessaging.instance.subscribeToTopic('receptionists_topic');
        // FirebaseMessaging.instance.subscribeToTopic('admins_topic');
        // FirebaseMessaging.instance.subscribeToTopic('lab_technicians_topic');
        // FirebaseMessaging.instance.subscribeToTopic('radiologists_topic');
        // FirebaseMessaging.instance.subscribeToTopic('accountants_topic');
        // FirebaseMessaging.instance.subscribeToTopic('managers_topic');
        // FirebaseMessaging.instance.subscribeToTopic('secretaries_topic');

        THelperFunctions.navigateAndReplaceScreen(HomeScreen());
      }
    });
  }

  @override
  void dispose() {
    AnimationHelper.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          //width: 1040px;
          // height: 692px;
          // flex-shrink: 0;
          Image.asset(AppImages.splashScreenImage),
          SizedBox(
            // height: 200.77.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(32.0.sp),
                  child: Image.asset(
                    AppImages.logoName,
                    color: AppColors.white,
                    //width: 160.w,height: 100.68.h,
                  ),
                ),

                // Text('د/عبدالرازق محمد', style: GoogleFonts.ibmPlexMono(fontSize: 20.sp,
                //
                //   fontWeight: FontWeight.w500,color: Colors.white,),),
                SizedBox(
                  height: 160.h,
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 111.h,
                  ),
                  child: SizedBox(
                    height: 61.h,
                    width: 61.h,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeAlign: .5,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 7,
                      backgroundColor: AppColors.primary0.shade300,
                    ),
                  )))
        ],
      ),
    );
  }
}
