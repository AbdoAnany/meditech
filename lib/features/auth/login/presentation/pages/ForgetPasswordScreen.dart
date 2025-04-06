import 'package:meditech/core/constants/image_strings.dart';
import 'package:meditech/core/helpers/helper_functions.dart';
import 'package:meditech/core/widget/MainButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BaseScaffold.dart';
import 'OTPScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool isChecked = false;

  // bool isPasswordVisible = false;

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
    return BaseScaffold(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            SizedBox(
              height: 95.h,
            ),
            SizedBox(
              width: 358.w,
              child: Text(
                'هل نسيت الباسورد؟',
                textAlign: TextAlign.right,
                style: GoogleFonts.ibmPlexSansArabic(
                  color: Color(0xFF1D2035),
                  fontSize: 24.w,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            SizedBox(
              width: 358.w,
              child: Text(
                'نزل رقمك اللي مسجل عندنا وهيجيلك كود تغيير كلمة السر !',
                textAlign: TextAlign.right,
                style: GoogleFonts.ibmPlexSansArabic(
                  color: Color(0xFF637D92),
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  height: 0.09,
                ),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            SizedBox(
              width: 398.w,
              height: 27.h,
              child: Text(
                'رقم الهاتف',
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _IraqPhoneNumberFormatter(),
              ],
              textDirection: TextDirection.rtl,
              onChanged: (w) {
                formKey.currentState?.validate();

                isChecked = w.isNotEmpty ? true : false;
                setState(() {});
              },
              style: GoogleFonts.ibmPlexSansArabic(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF7991A4)),
              validator: (email) {
                if (email!.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                fillColor: Color(0xFFF7F7F7),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFE7EBEF), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFE7EBEF), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFE7EBEF), width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(width: 1, color: Color(0xFFE84E5D)),
                ),
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

                hintStyle: GoogleFonts.ibmPlexSansArabic(
                  color: Color(0xFF7991A4),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  height: 0.09,
                ),

                hintText: "000 - 000 - 0000 ",
                // prefixIconConstraints: BoxConstraints(
                //   minWidth: 137.w,
                //   minHeight: 48.h,
                // ),
                prefixIcon: Container(
                  // width: 140,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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

                // Add more decoration..
              ),
            ),
            SizedBox(height: 28.h),
            MainButton(
              title: "تاكيد",
              onPressed: !isChecked
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        THelperFunctions.navigateToScreen(OTPScreen());
                      }
                      // THelperFunctions.navigateToScreen(const OTPScreen());
                    },
            ),
            SizedBox(height: 46.21.h),
          ],
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
