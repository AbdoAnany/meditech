// auth_cubit.dart
import 'dart:math';

import 'package:meditech/features/1-login/presentation/pages/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditech/core/constants/image_strings.dart';
import 'package:meditech/core/widget/AppLogoName.dart';
import 'package:meditech/core/widget/MainButton.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/Enums.dart';
import '../../../../core/constants/colors.dart';
import '../../data/models/user_model.dart';
import '../manager/login_cubit.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? _gender;
  DateTime? _dateOfBirth;

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // context.read<AuthCubit>().checkSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                 SizedBox(height: MediaQuery.of(context).padding.top),
                  // Center(child: AppLogoName()),
                  SizedBox(height: 16.h),
                  _buildTextField(
                      "الاسم الكامل",
                      _fullNameController,
                      _icon(
                        Icons.person,
                      ),
                      "أدخل الاسم الكامل"),
                  _buildTextField("رقم الهاتف", _phoneController, _prefixIcon(),
                      "أدخل رقم الهاتف",
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        EgyptianPhoneFormatter(),
                      ]),
                  _buildTextField("العنوان", _addressController,
                      _icon(Icons.location_on), "أدخل العنوان"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDateOfBirthPicker(),
                      _buildGenderRadioButtons(),
                      SizedBox()
                    ],
                  ),
                  Row(children: [
                    Expanded(
                        child: _buildTextField(
                            "الوزن (كجم)",
                            _weightController,
                            SizedBox(
                                width: 30,
                                child: Center(
                                  child: Text('kg',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.grayBlueP)),
                                )),
                            "أدخل الوزن",
                            keyboardType: TextInputType.number)),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                        child: _buildTextField(
                            "الطول (سم)",
                            _heightController,
                            SizedBox(
                                width: 30,
                                child: Center(
                                  child: Text('cm',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.grayBlueP)),
                                )),
                            "أدخل الطول",
                            keyboardType: TextInputType.number)),
                  ]),
                  _buildTextField("كلمة السر", _passwordController,
                      _icon(Icons.lock), "أدخل كلمة السر",
                      isPassword: true),
                  _buildTextField("تأكيد كلمة السر", _confirmPasswordController,
                      _icon(Icons.lock), "تأكيد كلمة السر",
                      isPassword: true),
                  SizedBox(height: 48.h),
                  MainButton(
                    title: "إنشاء حساب جديد",
                    onPressed: state is AuthLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final user = UserModel(
                                fullName: _fullNameController.text,
                                phone: _phoneController.text,
                                address: _addressController.text,
                                password: _passwordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text,
                                gender: _gender,
                                userType: UserRole.patient.name,
                                dateOfBirth: _dateOfBirth?.toIso8601String(),
                                weight: double.tryParse(_weightController.text),
                                height: double.tryParse(_heightController.text),
                                id: Random().nextInt(100000).toString(),
                              );
                              await context
                                  .read<AuthCubit>()
                                  .signUp(user: user);
                            }
                          },
                  ),
                  SizedBox(height: 16.h),
                  _buildLoginLink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      Widget prefixIcon, String hintText,
      {bool isPassword = false,
      List<TextInputFormatter>? formatters,
      TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: (12.0)),
          child: Text(
            label,
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppColors.textPrimaryLight,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          controller: controller,
          isPassword: isPassword,
          prefixIcon: prefixIcon,
          hintText: hintText,
          inputFormatters: formatters,
          keyboardType: keyboardType,
          validator: (value) {
            if (value!.isEmpty) {
              return "هذا الحقل مطلوب";
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildGenderRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: (12.0)),
          child: Text(
            "الجنس",
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppColors.textPrimaryLight,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Radio<String>(
              value: "ذكر",
              activeColor: AppColors.primary,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
            Text("ذكر"),
            Radio<String>(
              value: "أنثى",
              activeColor: AppColors.primary,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
            Text("أنثى"),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildDateOfBirthPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: (8.0)),
          child: Text(
            "تاريخ الميلاد",
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppColors.textPrimaryLight,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (selectedDate != null) {
              setState(() {
                _dateOfBirth = selectedDate;
              });
            }
          },

          // fillColor: Color(0xFFF7F7F7),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(16),
          //           borderSide: BorderSide(color: Color(0xFFE7EBEF), width: 1),
          //         ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              border: Border.all(color: Color(0xFFE7EBEF)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Iconsax.calendar_1, color: Color(0xFF7991A4)),
                SizedBox(width: 8.w),
                Text(
                  _dateOfBirth != null
                      ? "${_dateOfBirth!.toLocal()}".split(' ')[0]
                      : "اختر تاريخ الميلاد",
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.textPrimaryLight,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'لديك حساب؟',
          style: GoogleFonts.ibmPlexSansArabic(
            color: Color(0xFF1D2035),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          child: Text(
            'تسجيل الدخول',
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
        ),
      ],
    );
  }

  _icon(iconDate) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Icon(
        iconDate,
        color: Color(0xFF7991A4),
      ),
    );
  }

  Widget _prefixIcon() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.egFlag,
            height: 24.w,
            width: 24.w,
          ),
          SizedBox(width: 8.w),
          Text(
            "20+",
            style: GoogleFonts.ibmPlexSansArabic(
              color: Color(0xFF323F49),
              fontSize: 14.w,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF7991A4)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            height: 14.w,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.50.w,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFF7991A4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EgyptianPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Remove non-digit characters
    final newText = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Egyptian numbers are 11 digits
    if (newText.length > 11) {
      return oldValue;
    }

    final sb = StringBuffer();

    // Format as: 01x xxxx xxxx
    for (int i = 0; i < newText.length; i++) {
      // if (i == 3 || i == 7) {
      //   sb.write(' ');
      // }
      sb.write(newText[i]);
    }

    return TextEditingValue(
      text: sb.toString(),
      selection: TextSelection.collapsed(offset: sb.length),
    );
  }
}
