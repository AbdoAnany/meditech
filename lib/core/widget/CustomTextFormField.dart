import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final String label;
  final Widget? prefixIcon;

  const CustomTextFormField({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.onChanged,
    this.label='',
    this.validator,
    this.hintText = "",
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 398.w,
          height: 27.h,
          child: Text(
            label,
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
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF7991A4),
          ),
          validator: validator,
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
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            hintStyle: GoogleFonts.ibmPlexSansArabic(
              color: Color(0xFF7991A4),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            hintText: hintText,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
