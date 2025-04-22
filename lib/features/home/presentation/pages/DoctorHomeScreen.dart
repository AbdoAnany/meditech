import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditech/features/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/Global.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_strings.dart';


import '../../../../di.dart';
import '../../../appointment/presentation/manager/appointment_cubit.dart';
import '../../../appointment/presentation/widgets/appointment_card.dart';
import '../../../service/presentation/pages/service_page.dart';
import 'home_screen.dart';



class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                SizedBox(height: 16.h),
                _buildDoctorProfileCard(),
                SizedBox(height: 24.h),
                ServicePage(),

                // SizedBox(height: 24.h),
                // _buildSectionHeader(
                //   title: "العروض الحالية",
                //   onSeeMoreTap: () => _navigateToAllOffers(context),
                // ),
                // SizedBox(height: 16.h),
                // _buildOffersList(),
                SizedBox(height: 24.h),
                _buildSectionHeader(
                  title: "المواعيد القادمة",
                  onSeeMoreTap: () => _navigateToAllAppointments(context),
                ),
                SizedBox(height: 16.h),
                 _buildAppointmentsList(),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildAppointmentsList() {
  return  BlocProvider<AppointmentCubit>(
      create: (context) => get_it<AppointmentCubit>()..fetchAppointments(),
      child:
      BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
          if (state is AppointmentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AppointmentLoaded) {
            return  ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
    itemCount: (state.appointments??[]).length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (_, index) => AppointmentCardHistory(appointment: (state.appointments??[])[index]),
    );

            // _buildAppointmentTabs(state.appointments??[]);
          } else if (state is AppointmentError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Unknown state"));
        },
      ));

  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        Text(
          "${Global.userDate?.fullName ?? 'دكتور'} 👋",
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => _navigateToNotifications(context),
          icon: const Icon(Iconsax.notification),
          // color: const Color(0xFF1D2035),
        ),
      ],
    );
  }

  Widget _buildDoctorProfileCard() {
    return Container(
      height: 140.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Row(
          children: [
            Container(
              // height: 120.h,
              width: 110.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.logoName),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
               "أفضل  لخدمتك  للك",
                    style: GoogleFonts.ibmPlexSansArabic(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '',
                    style: GoogleFonts.ibmPlexSansArabic(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildStatusIndicator(
                    isAvailable: true,
                    appointmentsCount: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator({
    required bool isAvailable,
    required int appointmentsCount,
  }) {
    return Row(
      children: [
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        //   decoration: BoxDecoration(
        //     color: isAvailable ? Colors.green.shade400 : Colors.red.shade400,
        //     borderRadius: BorderRadius.circular(16.r),
        //   ),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Icon(
        //         isAvailable ? Icons.check_circle : Icons.cancel,
        //         color: Colors.white,
        //         size: 14.sp,
        //       ),
        //       SizedBox(width: 4.w),
        //       Text(
        //         isAvailable ? 'متاح' : 'غير متاح',
        //         style: GoogleFonts.ibmPlexSansArabic(
        //           color: Colors.white,
        //           fontSize: 12.sp,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.calendar,
                color: Colors.white,
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                '$appointmentsCount مواعيد اليوم',
                style: GoogleFonts.ibmPlexSansArabic(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onSeeMoreTap,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.ibmPlexSansArabic(
            color: const Color(0xFF1D2035),
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



  Widget _buildOffersList() {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: PageView(
        children: [
          _buildOfferCard(
            title: "خصم 25% على عملية تكميم المعدة",
            subtitle: "العرض ساري حتى نهاية الشهر",
            imagePath: AppImages.banner1,
            backgroundColor: const Color(0xFF4A6572),
          ),
          _buildOfferCard(
            title: "استشارة مجانية للحالات الجديدة",
            subtitle: "لأول 10 مرضى هذا الأسبوع",
            imagePath: AppImages.banner1,
            backgroundColor: const Color(0xFF344955),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required Color backgroundColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            backgroundColor.withOpacity(0.7),
            BlendMode.srcOver,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: GoogleFonts.ibmPlexSansArabic(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: GoogleFonts.ibmPlexSansArabic(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                "استفد من العرض",
                style: GoogleFonts.ibmPlexSansArabic(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  // Helper methods
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatTime(DateTime date) {
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  // Navigation methods
  void _navigateToNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationScreen()),
    );
  }



  void _navigateToAllOffers(BuildContext context) {
    // Implement navigation to all offers screen
  }

  void _navigateToAllAppointments(BuildContext context) {

    HomeScreen.tabNotifier.value = 1; // 👈 Navigates to 'البرامج'

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const AppointmentScreen()),
      // );
    }
}
