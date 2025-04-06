import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String departmentId;
  final IconData iconData;
  final double? price;
  final bool? hasOffer;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.departmentId,
    required this.iconData,
    this.price,
    this.hasOffer,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'],
      title: map['title'],
      departmentId: map['departmentId'],
      description: map['description'],
      iconData: Iconsax.health, // or map an icon string to IconData
      price: map['price']?.toDouble(),
      hasOffer: map['hasOffer'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'departmentId': departmentId,
      'description': description,
      'price': price,
      'hasOffer': hasOffer,
    };
  }
}
