
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/models/ServiceModel.dart';
import '../pages/ServiceDetailsPage.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key,required this.service});
final ServiceModel service;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap event
        // For example, navigate to a detailed service page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailsPage(service: service),
          ),
        );
      },
      child: Container(
        width: 200.w,
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade300,
          //     blurRadius: 8,
          //     offset: Offset(0, 4),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon inside circle
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal.withOpacity(0.1),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Icon(getIconFromName(service.departmentId), size: 20, color: Colors.teal),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    service.title,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,

                      // fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),




            // Title


            SizedBox(height: 6),

            // Description
            Text(
              service.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
            ),

            if (service.hasOffer == true && service.price != null) ...[
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "السعر: ${service.price} جنيه",
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
  IconData getIconFromName(String iconName) {
    switch (iconName) {
      case 'health':
        return Iconsax.health;
      case 'activity':
      case 'fitness':
        return Iconsax.activity;
      case 'clipboard_text':
      case 'followup':
        return Iconsax.clipboard_text;
      case 'diet':
      case 'nutrition':
        return Iconsax.direct;
      case 'flask':
      case 'lab':
        return Iconsax.happyemoji;
      case 'emoji_happy':
      case 'psychology':
        return Iconsax.emoji_happy;
      case 'coffee':
        return Iconsax.coffee;
      case 'hospital':
      case 'surgery':
        return Iconsax.hospital;
      case 'medal':
      case 'physiotherapy':
        return Iconsax.medal;
      case 'dumbbell':
        return Iconsax.command_square; // استخدم الأيقونة المناسبة إن لم تكن موجودة في Iconsax
      case 'consultation':
        return Iconsax.user; // اختر أيقونة مناسبة للاستشارة
      default:
        return Iconsax.info_circle;
    }
  }

}
