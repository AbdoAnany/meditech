
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditech/features/service/data/models/ServiceModel.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/repositories/ServiceRepository.dart';
import '../widgets/service_card.dart';
import '../widgets/service_header.dart';
import 'all_service_page.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});
  final String departmentId = ""; // Replace with actual department ID

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ServiceHeader(
          title: "الخدمات",
          onSeeMoreTap: () => _navigateToAllServices(context),
        ),
        SizedBox(height: 16.h),
        FutureBuilder<List<ServiceModel>>(
          future: ServiceRepository().getServicesByDepartment(departmentId),
          builder: (context, snapshot) {
            final services = snapshot.data ?? [];

            return Skeletonizer(
              enabled: !snapshot.hasData,
              child: SizedBox(
                height: 170.h,
                child: services.isEmpty
                    ? Center(child: Text("لا توجد خدمات حالياً"))
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: services.length,
                  itemBuilder: (context, index) =>
                      ServiceCard(service: services[index]),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
  void _navigateToAllServices(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const AllServicesScreen()),
    // );
  }
}


