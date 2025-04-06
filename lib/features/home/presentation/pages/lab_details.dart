import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_strings.dart';

class LabDetails extends StatelessWidget {
  const LabDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("المختبر"),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.favorite_border),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      backgroundColor: AppColors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                        AppImages.banner3), // replace with your image asset
                    Positioned(
                      top: 16.0,
                      right: 16.0,
                      child: Icon(Icons.favorite, color: Colors.red),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "المختبر",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text("40 عاماً من الخدمة"),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Text("3.2"),
                          Spacer(),
                          Text("60 فرع"),
                        ],
                      ),
                      Divider(),
                      ListTile(
                        title: Text("تحليل"),
                        trailing: Icon(Icons.arrow_drop_down),
                      ),
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("وظائف الكبد SGOT ,SGPT"),
                              subtitle: Text("220 جنيه بدلاً من 400 جنيه"),
                              trailing: Text("ج.م 220"),
                            ),
                            ListTile(
                              title: Text("سرعة ترسيب ESR"),
                              subtitle: Text("180 جنيه بدلاً من 250 جنيه"),
                              trailing: Text("ج.م 180"),
                            ),
                            ListTile(
                              title: Text("مزرعة في الأذن C/S Ear"),
                              subtitle: Text("400 جنيه بدلاً من 750 جنيه"),
                              trailing: Text("ج.م 400"),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("إجمالي الخدمات"),
                        trailing: Text("ج.م 400"),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("طلب الخدمة"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
