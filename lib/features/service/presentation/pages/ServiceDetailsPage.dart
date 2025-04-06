import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditech/core/constants/colors.dart';
import 'package:meditech/features/service/data/models/ServiceModel.dart';

class ServiceDetailsPage extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(service.title),
      ),

      backgroundColor:AppColors.background,


      body: Container(
        padding: EdgeInsets.all(16.0.w),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,

          children: [

            Icon(service.iconData, size: 60, color: Colors.teal),
            SizedBox(height: 16),
            Text(
              service.title,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              service.description,
              style: TextStyle(fontSize: 16.sp),
            ),
            if (service.price != null) ...[
              SizedBox(height: 20),
              Text(
                "السعر: ${service.price} جنيه",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
