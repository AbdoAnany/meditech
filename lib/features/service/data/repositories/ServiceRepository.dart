import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ServiceModel.dart';

class ServiceRepository {
  Future<List<ServiceModel>> getServicesByDepartment(String departmentId) async {

    if(departmentId.isNotEmpty){
    final querySnapshot = await FirebaseFirestore.instance
        .collection('services')
        .where('departmentId', isEqualTo: departmentId
    )
        .get();
    return querySnapshot.docs
        .map((doc) => ServiceModel.fromMap(doc.data()))
        .toList();
    }
// if(departmentId.isEmpty){
  final querySnapshot = await FirebaseFirestore.instance
      .collection('services').get();
  return querySnapshot.docs
      .map((doc) => ServiceModel.fromMap(doc.data()))
      .toList();
// }

  }

  Future<void> seedDummyServices() async {
    // final List<Map<String, dynamic>> dummyServices = [...]; // كما هو

    final List<Map<String, dynamic>> services = [
      {
        "id": "1",
        "title": "عملية تكميم المعدة",
        "description": "عملية جراحية لتقليل حجم المعدة",
        "iconName": "health",
        "price": 15000,
        "hasOffer": true,
        "departmentId": "surgery"
      },
      {
        "id": "2",
        "title": "استشارة سمنة",
        "description": "استشارة طبية لحالات السمنة",
        "iconName": "activity",
        "price": 300,
        "hasOffer": false,
        "departmentId": "consultation"
      },
      {
        "id": "3",
        "title": "متابعة ما بعد العملية",
        "description": "متابعة حالة المريض بعد العملية",
        "iconName": "clipboard_text",
        "price": 200,
        "hasOffer": false,
        "departmentId": "followup"
      },
      {
        "id": "4",
        "title": "نظام غذائي مخصص",
        "description": "وضع خطة غذائية للمريض",
        "iconName": "diet",
        "price": 400,
        "hasOffer": true,
        "departmentId": "nutrition"
      },
      {
        "id": "5",
        "title": "تحاليل شاملة",
        "description": "تحاليل مخبرية شاملة قبل العملية",
        "iconName": "flask",
        "price": 600,
        "hasOffer": true,
        "departmentId": "lab"
      },
      {
        "id": "6",
        "title": "جلسة نفسية",
        "description": "جلسة مع أخصائي نفسي للتحضير للعملية",
        "iconName": "emoji_happy",
        "price": 350,
        "hasOffer": false,
        "departmentId": "psychology"
      },
      {
        "id": "7",
        "title": "جلسة متابعة تغذية",
        "description": "متابعة التغذية بعد العملية",
        "iconName": "coffee",
        "price": 250,
        "hasOffer": true,
        "departmentId": "nutrition"
      },
      {
        "id": "8",
        "title": "استشارة جراح",
        "description": "لقاء مع الجراح قبل العملية",
        "iconName": "hospital",
        "price": 500,
        "hasOffer": false,
        "departmentId": "surgery"
      },
      {
        "id": "9",
        "title": "جلسة علاج طبيعي",
        "description": "إعادة تأهيل بعد العملية",
        "iconName": "medal",
        "price": 700,
        "hasOffer": true,
        "departmentId": "physiotherapy"
      },
      {
        "id": "10",
        "title": "نظام رياضي",
        "description": "وضع خطة رياضية مناسبة بعد العملية",
        "iconName": "dumbbell",
        "price": 300,
        "hasOffer": false,
        "departmentId": "fitness"
      },
    ];
    final firestore = FirebaseFirestore.instance;

    for (var service in services) {
      await firestore.collection('services').add(service);
    }

    print("✅ Services seeded successfully!");
  }
}
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
