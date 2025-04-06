import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurgeryScreen extends StatelessWidget {
  final List<Map<String, String>> surgeries = [
    {
      'title': 'عملية الساسي',
      'description': 'عملية الساسي من العمليات الجراحية التي...',
      'image':
          'https://www.meditech.com/images/services/%D8%AA%D9%83%D9%85%D9%8A%D9%85%20%D8%A7%D9%84%D9%85%D8%B9%D8%AF%D8%A9.jpg.webp',
    },
    {
      'title': 'عملية تحويل المسار المصغر',
      'description': 'عملية تحويل المسار مناسبة للأشخاص...',
      'image':
          'https://www.meditech.com/images/services/%D8%B9%D9%85%D9%84%D9%8A%D8%A9%20%D8%AA%D8%AD%D9%88%D9%8A%D9%84%20%D8%A7%D9%84%D9%85%D8%B3%D8%A7%D8%B1%20%D8%A7%D9%84%D9%85%D8%B5%D8%BA%D8%B1.png.webp',
    },
    {
      'title': 'عملية تكميم المعدة',
      'description': 'هي أكبر عمليات السمنة انتشارًا...',
      'image':
          'https://www.meditech.com/images/services/%D8%B9%D9%85%D9%84%D9%8A%D8%A9%20%D8%A7%D9%84%D8%B3%D8%A7%D8%B3%D9%8A.jpg.webp',
    },
    {
      'title': 'عمليات تصحيح',
      'description': 'عمليات التصحيح تتم في حالة فشل جراحات السمنة...',
      'image':
          'https://www.meditech.com/images/services/%D8%B9%D9%85%D9%84%D9%8A%D8%A9-%D8%A7%D9%84%D8%A8%D8%A7%D9%84%D9%88%D9%86-%D9%84%D9%84%D9%85%D8%B9%D8%AF%D8%A9.jpg.webp',
    },
    {
      'title': 'الكبسولة الذكية',
      'description': 'الكبسولة الذكية الحل الأمثل بدون جراحة...',
      'image':
          'https://www.meditech.com/images/services/%D8%A7%D9%84%D9%83%D8%A8%D8%B3%D9%88%D9%84%D8%A9%20%D8%A7%D9%84%D8%B0%D9%83%D9%8A%D8%A9.jpg.webp',
    },
    {
      'title': 'بالون المعدة وأنواعه',
      'description': 'بالون المعدة مناسب للأشخاص...',
      'image':
          'https://www.meditech.com/images/services/%D8%AA%D8%B5%D8%AD%D9%8A%D8%AD.png.webp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white,
        // border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      // height: 100.h,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // عدد الأعمدة
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          mainAxisExtent: 150, // الطول
          childAspectRatio: .9, // نسبة الطول إلى العرض
        ),
        itemCount: surgeries.length,
        itemBuilder: (context, index) {
          return SurgeryCard(
            title: surgeries[index]['title']!,
            description: surgeries[index]['description']!,
            imagePath: surgeries[index]['image']!,
          );
        },
      ),
    );
  }
}

class SurgeryCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const SurgeryCard({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      // height: 100.h,
      // width: MediaQuery.of(context).size.width / 4.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

         Container(
           height: 80.h,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.only(
               topLeft: Radius.circular(12),
               topRight: Radius.circular(12),
             ),
             image: DecorationImage(
               image: NetworkImage(imagePath),
               fit: BoxFit.cover,
             ),


            ),


         ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 100.w,
            child: Text(title,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child: Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey)),
          // ),

          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: Icon(Icons.local_hospital),
          //   label: Text("تفاصيل"),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.teal,
          //     foregroundColor: Colors.white,
          //   ),
          // ),
          // SizedBox(height: 10),
        ],
      ),
    );
  }
}
