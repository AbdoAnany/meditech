
import 'package:meditech/core/helpers/helper_functions.dart';
import 'package:meditech/core/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/Enums.dart';
import '../../../../core/constants/Global.dart';
import '../../../../core/constants/StringKeys.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_strings.dart';
import '../widgets/ProfileListItem.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primary0.shade100,
                    borderRadius: BorderRadius.circular(16.r)),
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                width: double.infinity,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          AppImages.person_dr), // Replace with your asset image
                    ),
                    SizedBox(width: 10.w),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          Global.userDate?.userType ?? '',
                          style: TextStyle(
                            fontSize: 16.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          Global.userDate?.fullName ?? '',
                          style: TextStyle(
                            fontSize: 16.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(height: 10),
                        // Text(
                        //   '+2${user?.phone??''}',
                        //   style: TextStyle(fontSize: 14.w,
                        //
                        //     color: AppColors.grayBlueP,
                        //   ),
                        // ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              " ${THelperFunctions.calAge(DateTime.tryParse(Global.userDate?.dateOfBirth ?? ''))}  العمر ",
                              style: TextStyle(
                                fontSize: 14.w,
                                color: AppColors.grayBlueP,
                              ),
                            ),
                            Text(
                              " | ${THelperFunctions.getFormattedDate(DateTime.tryParse(Global.userDate?.dateOfBirth ?? ''))} تاريخ الميلاد ",
                              style: TextStyle(
                                fontSize: 14.w,
                                color: AppColors.grayBlueP,
                              ),
                            ),
                          ],
                        ), // Text(
                        //   'المستخدم',
                        //   style: TextStyle(
                        //     fontSize: 16.sp,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ProfileListItem(
                            icon: Iconsax.user,
                            text: 'البيانات الشخصية',
                          ),
                          ProfileListItem(
                            icon: Iconsax.health,
                            text: 'نصائح الطبيب',
                          ),
                          ProfileListItem(
                            icon: Iconsax.note,
                            text: 'مقالات ',
                          ),
                          ProfileListItem(
                            icon: Iconsax.location,
                            text: 'الفروع',
                          ),
                          ProfileListItem(
                            icon: Iconsax.notification,
                            text: 'الإشعارات',
                          ),
                          // ProfileListItem(
                          //   icon: Iconsax.language_circle,
                          //   text: 'اللغة',
                          //   trailing: LanguageToggle(),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 0.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ProfileListItem(
                            icon: Iconsax.support,
                            text: 'الدعم',
                          ),
                          // ProfileListItem(
                          //   icon: Iconsax.like_dislike,
                          //   text: 'تقييم التطبيق',
                          // ),
                          ProfileListItem(
                            icon: Iconsax.message_question,
                            text: 'الأسئلة المتكررة',
                          ),
                          ProfileListItem(
                            onTap: () async {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            icon: Iconsax.info_circle,
                            text: 'معلومات عنا',
                          ),
                          ProfileListItem(
                            onTap: () async {
                              _showMyDialog(context);

                              // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            icon: Iconsax.profile_delete,
                            color: Colors.red,
                            text: 'حذف الحساب',
                          ),
                          ProfileListItem(
                            onTap: () async {
                              if (Global.userDate?.userType ==
                                  UserRole.patient.name) {
                                FirebaseMessaging.instance.unsubscribeFromTopic(
                                    'patients_topic_${Global.userDate?.phone}');
                              }
                              if (Global.userDate?.userType ==
                                  UserRole.doctor.name) {
                                FirebaseMessaging.instance
                                    .unsubscribeFromTopic('doctors_topic');
                              }
                              FirebaseMessaging.instance
                                  .unsubscribeFromTopic('all_topic');
                              await TLocalStorage()
                                  .removeData(StringKeys.userInfo);

                              await FirebaseAuth.instance.signOut();

                              // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            icon: Iconsax.logout_1,
                            text: 'تسجيل الخروج',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('V1.2.0  |  سياسة الخصوصية  |  الشروط والأحكام'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          // title: Text('حذف الحساب'),
          content: SizedBox(
            height: 30,
            child: Center(
              child: Text('هل تريد حذف الحساب؟',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.w,
                  )),
            ),
          ),
          icon: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red.withOpacity(0.07),
              child:
                  Icon(Iconsax.profile_delete, size: 40.sp, color: Colors.red)),
          actionsPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              child: Text('موافق',
                  style: TextStyle(fontSize: 18.sp, color: Colors.red)),
              onPressed: () async {
                if (Global.userDate?.userType == UserRole.patient.name) {
                  FirebaseMessaging.instance.unsubscribeFromTopic(
                      'patients_topic_${Global.userDate?.phone}');
                }
                if (Global.userDate?.userType == UserRole.doctor.name) {
                  FirebaseMessaging.instance
                      .unsubscribeFromTopic('doctors_topic');
                }
                FirebaseMessaging.instance.unsubscribeFromTopic('all_topic');
                Navigator.of(context).pop();

                await TLocalStorage().removeData(StringKeys.onBoarding);
                await TLocalStorage().removeData(StringKeys.userInfo);

                await FirebaseAuth.instance.signOut();
              },
            ),
            TextButton(
              child: Text('لا',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
