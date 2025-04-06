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
