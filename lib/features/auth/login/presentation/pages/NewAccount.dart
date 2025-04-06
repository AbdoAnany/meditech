import 'package:meditech/core/constants/image_strings.dart';
import 'package:meditech/core/helpers/helper_functions.dart';
import 'package:meditech/core/widget/MainButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/widget/CustomTextFormField.dart';
import 'OTPScreen.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen({super.key});

  @override
  State<NewAccountScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<NewAccountScreen> {
  bool isChecked = false;

  bool isPasswordVisible = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(' top :' + MediaQuery.of(context).padding.top.toString());
    print(' bottom :' + MediaQuery.of(context).padding.bottom.toString());
    print(' height :' + MediaQuery.of(context).size.height.toString());
    print(' width :' + MediaQuery.of(context).size.width.toString());
    print(' 1 w :' + 1.w.toString());
    print(' 1 h:' + 1.h.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  // Center(
                  //   child:  AppLogoName(),),
                  // SizedBox(
                  //   height: 38.h,
                  // ),
                  SizedBox(
                    width: 382,
                    height: 49,
                    child: Text(
                      'إنشاء حساب جديد 👏',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: Color(0xFF1D2035),
                        fontSize: 24.sp,

                        fontWeight: FontWeight.w700,
                        //    height: 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomTextFormField(
                    label: 'إسم المستخدم',
                    keyboardType: TextInputType.text,
                    hintText: "عبدالله عز الدين ",
                    prefixIcon: Icon(Iconsax.profile_tick),
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.digitsOnly,
                    //   _IraqPhoneNumberFormatter(),
                    // ],

                    validator: (email) {
                      if (email!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    label: 'رقم الهاتف',
                    keyboardType: TextInputType.phone,
                    hintText: "000 - 000 - 0000 ",
                    prefixIcon: Container(
                      // width: 140,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 16.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.iraqFlag,
                            height: 24.w,
                            width: 24.w,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "964+",
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
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      _IraqPhoneNumberFormatter(),
                    ],
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 24.h),
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
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    obscureText: isPasswordVisible,
                    textDirection: TextDirection.rtl,
                    obscuringCharacter: "*",
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onChanged: (w) {
                      formKey.currentState?.validate();
                      setState(() {});
                    },
                    style: GoogleFonts.ibmPlexSansArabic(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7991A4)),
                    decoration: InputDecoration(
                        fillColor: Color(0xFFF7F7F7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(0xFFE7EBEF), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(0xFFE7EBEF), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Color(0xFFE7EBEF), width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE84E5D)),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 18.h, horizontal: 16.w),
                        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

                        hintStyle: GoogleFonts.ibmPlexSansArabic(
                          color: Color(0xFF7991A4),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          height: 0.09,
                        ),
                        hintText: "يرجي ادخال كلمة السر..",
                        // prefixIconConstraints: BoxConstraints(
                        //   minWidth: 137.w,
                        //   minHeight: 48.h,
                        // ),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: Icon(isPasswordVisible
                                ? Iconsax.eye
                                : Iconsax.eye_slash))

                        // Add more decoration..
                        ),
                  ),

                  SizedBox(height: 50),
                  MainButton(
                    title: "الانضمام",
                    onPressed:
                        // !formKey.currentState!.validate()?null:
                        () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        THelperFunctions.navigateToScreen(OTPScreen());
                      }
                      // THelperFunctions.navigateToScreen(const OTPScreen());
                    },
                  ),
                  SizedBox(height: 46.21.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            // width: 117.w,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1.w,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFCED7DE),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17.0.w),
                          child: Text(
                            'الإنضمام اسرع باستخدام',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSansArabic(
                              color: Color(0xFF7991A4),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            // width: 117.w,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1.w,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFCED7DE),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                  SizedBox(height: 33.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(width: ,)
                      Container(
                        margin: EdgeInsets.zero,

                        height: 60.h,
                        constraints: BoxConstraints(
                          minWidth: 135.w,
                          minHeight: 60.h,
                          maxWidth: 185.w,
                          maxHeight: 60.h,
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 32.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFFEEEEEE),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.apple,
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'ابل',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: Color(0xFF4A5E6D),
                                fontSize: 14.sp,
                                // fontFamily: 'IBM Plex Sans Arabic',
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(width: 32.w,),
                      Container(
                        margin: EdgeInsets.zero,
                        constraints: BoxConstraints(
                          minWidth: 135.w,
                          minHeight: 60.h,
                          maxWidth: 185.w,
                          maxHeight: 60.h,
                        ),
                        width: 191.w,
                        height: 60.h,
                        // padding: EdgeInsets.symmetric(horizontal: 71.w),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFFEEEEEE),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.google,
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'جوجل',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: Color(0xFF4A5E6D),
                                fontSize: 14.sp,
                                // fontFamily: 'IBM Plex Sans Arabic',
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 84.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' لدي حساب بالفعل ؟!',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: Color(0xFF92A5B5),
                          fontSize: 16.sp,
                          // fontFamily: 'IBM Plex Sans Arabic',
                          fontWeight: FontWeight.w500,
                          // height: 0.09,
                        ),
                      ),
                      SizedBox(
                        width: 11.w,
                      ),
                      TextButton(
                        onPressed: () {
                          THelperFunctions.navigateToScreen(NewAccountScreen());
                        },
                        child: Text(
                          'تسجيل دخول',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: AppColors.primary,
                            fontSize: 16,
                            // fontFamily: 'IBM Plex Sans Arabic',
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            // height: 0.09,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IraqPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Remove any non-digit characters
    final newText = text.replaceAll(RegExp(r'[^0-9]'), '');

    // If the length exceeds 10 digits (for Iraqi phone numbers), return old value
    if (newText.length > 10) {
      return oldValue;
    }

    final sb = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      if (i == 3 || i == 6) {
        sb.write('-');
      }

      sb.write(newText[i]);
    }

    return TextEditingValue(
      text: sb.toString(),
      selection: TextSelection.collapsed(offset: sb.length),
    );
  }
}
