class UserModel {
  final String id;

  final String fullName;
  final String phone;
  final String address;
  final String password;
  final String confirmPassword;
  final String? gender;
  final String? dateOfBirth;
  final double? weight;
  final double? height;
  final String? userType;

  UserModel({
    required this.fullName,
    required this.id,
    required this.phone,
    required this.address,
    required this.password,
    required this.confirmPassword,
    this.gender,
    this.dateOfBirth,
    this.weight,
    this.height,  this. userType,
  });

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
      id: map?['id']??'',
      fullName: map?['fullname']??'',
      phone: map?['phone']??'',
      userType: map?['userType']??'',
      address: map?['address']??'',
      password: map?['password']??'',
      confirmPassword: map?['confirmPassword']??'',
      gender: map?['gender']??'',
      dateOfBirth: map?['dateOfBirth'] ?? '',
      weight: map?['weight']?.toDouble()??0.0,
      height: map?['height']?.toDouble()??0.0,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id??'',
      'fullname': fullName ?? '',
      'phone': phone ?? '',
      'userType': userType ?? '',
      'address': address ?? '',
      'password': password ?? '',
      'confirmPassword': confirmPassword ?? '',
      'gender': gender ?? '',
      'dateOfBirth': dateOfBirth ?? '',
      'weight': weight ?? 0.0,
      'height': height ?? 0.0,

    };
  }

}
