import 'package:meditech/core/constants/image_strings.dart';
import 'package:meditech/core/widget/AppLogoName.dart';
import 'package:meditech/core/widget/MainButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/colors.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../manager/login_cubit.dart';
import '../widgets/custom_text_field.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController(text: '01118836732');
  final _passwordController = TextEditingController(text: '12345678');
  bool _isRememberMe = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkSavedCredentials();
  }
  // 201118836732@domain.com
  // 201118836732@domain.com

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
            MaterialPageRoute(builder: (_) => HomeScreen()),
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
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),

                  Center(
                    child: AppLogoName(),
                  ),

                  SizedBox(
                    height: 128.h,
                  ),
                  SizedBox(
                    width: 398.w,
                    height: 27.h,
                    child: Text(
                      'رقم الهاتف',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: AppColors.textPrimaryLight,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: _phoneController,
                    isPassword: false,
                    prefixIcon: _prefixIcon(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      EgyptianPhoneFormatter(),
                    ],
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onChanged: (w) {
                      _formKey.currentState?.validate();
                      setState(() {});
                    },
                    hintText: "أدخل رقم الهاتف",
                  ),

                  SizedBox(
                    height: 32.h,
                  ),
                  SizedBox(
                    width: 398.w,
                    height: 27.h,
                    child: Text(
                      'كلمة السر',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: Color(0xFF1D2035),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    isPassword: true,
                    onChanged: (w) {
                      _formKey.currentState?.validate();
                      setState(() {});
                    },
                    hintText: "يرجي ادخال كلمة السر..",
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CheckboxListTile(
                    value: _isRememberMe,
                    onChanged: (value) {
                      setState(() {
                        _isRememberMe = value ?? false;
                      });
                    },
                    title: Text('تذكرني'),
                  ),
                  SizedBox(
                    height: 64.h,
                  ),
                  MainButton(
                    title: "تسجيل الدخول",
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                    _phoneController.text,
                                    _passwordController.text,
                                    _isRememberMe,
                                  );
                            }
                          },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  // signInAnonymously
                  TextButton(
                      child: Text(
                        'تسجيل دخول كزائر',
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: Color(0xFF1D2035),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          height: 0.09,
                        ),
                      ),
                      onPressed: () async {
                        await context.read<AuthCubit>().signInAnonymously();
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RegisterScreen(),
                      ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لديك حساب؟',
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: Color(0xFF1D2035),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          height: 0.09,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'إنشاء حساب',
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: AppColors.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            height: 0.09,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  )

                  // ... Rest of your UI code
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _prefixIcon() {
    return Container(
      // width: 140,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.egFlag,
            height: 24.w,
            width: 24.w,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            "20+",
            style: GoogleFonts.ibmPlexSansArabic(
              color: Color(0xFF323F49),
              fontSize: 14.w,
              // fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.w700,
              // height: 0.10,
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF7991A4),
          ),
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
