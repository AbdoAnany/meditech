import 'package:meditech/core/helpers/helper_functions.dart';
import 'package:meditech/core/widget/MainButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widget/DynamicOtpField.dart';
import '../../../../home/presentation/pages/home_screen.dart';
import 'BaseScaffold.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
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

      child:  Form(
        key: formKey,
        child:Column(
          children: [
            // if(FocusManager.instance.primaryFocus != null)
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            SizedBox(
              height: 95.h,
            ),
            SizedBox(
              width: 358.w,
              child: Text(
                'تم إرسال رمز التحقق',
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
                'هتوصلك رسالة على تليفونك فيها كود التحقق.',
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
            DynamicOtpField(
              fieldWidth: 70.h,
              onSubmit: (value) {
                isChecked = value.length == 5;

                setState(() {});
                // THelperFunctions.navigateToScreen(const OTPScreen());
              },
            ),
            SizedBox(height: 48.h),
            SizedBox(
              width: 398.w,
              height: 24.h,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'لم أتلق الرمز ( ',
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: Color(0xFF1D2035),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 0.10,
                      ),
                    ),
                    TextSpan(
                      text: '30:00',
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: Color(0xFFFEAA43),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 0.10,
                      ),
                    ),
                    TextSpan(
                      text: ' )   ',
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: Color(0xFF1D2035),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 0.10,
                      ),
                    ),
                    TextSpan(
                      text: 'اعادة الارسال',
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: Color(0xFF516EFF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        height: 0.10,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 28.h),
            MainButton(
              title: "تأكيد",
              onPressed: !isChecked
                  ? null
                  : () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState?.save();
                  THelperFunctions.navigateToScreen(
                      const HomeScreen());
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
