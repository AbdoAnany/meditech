
import 'package:meditech/features/PlanScreen/PlanScreen.dart';
import 'package:meditech/features/appointment/presentation/pages/appoinment_screen.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/Global.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../profile/presentation/pages/ProfileScreen.dart';
import '../../../chat_section/screens/chat_list.dart';
import 'DoctorHomeScreen.dart';
import '../../../notification/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
    static ValueNotifier<int> tabNotifier = ValueNotifier<int>(0); // 👈

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    DoctorHomeScreen(),
    AppointmentsScreen(),
    ChatListScreen(),
   
    ProfileScreen(),
  ];

  @override
  void initState() {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }
  @override
void dispose() {
  // HomeScreen.tabNotifier.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          body: ValueListenableBuilder<int>(
            valueListenable: HomeScreen.tabNotifier,
            builder: (context, currentIndex, _) {
              return _screens[currentIndex];
            },
          ),
          bottomNavigationBar: SizedBox(
            height: 75.h,
            child: ValueListenableBuilder<int>(
              valueListenable: HomeScreen.tabNotifier,
              builder: (context, currentIndex, _) {
                return BottomNavigationBar(
                  backgroundColor: AppColors.scaffoldBackgroundColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex,
                  elevation: 0,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.textSecondary,
                  selectedLabelStyle: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  iconSize: 30.sp,
                  unselectedLabelStyle: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: (index) {
                    HomeScreen.tabNotifier.value = index;
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.home),
                      label: 'احجز الان',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.calendar_add),
                      label: 'الحجوزات',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.routing_2),
                      label: 'البرامج',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.user),
                      label: 'حسابي',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
