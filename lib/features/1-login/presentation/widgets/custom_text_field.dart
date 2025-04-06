import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final FormFieldValidator<String>? validator;
  void Function(String)?  onChanged;
  final List<TextInputFormatter>? inputFormatters;
final  TextInputType? keyboardType;
  Widget? prefixIcon;
   CustomTextField({
    Key? key,
    required this.controller,
    this.isPassword = false,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.inputFormatters, this.keyboardType,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:widget.keyboardType??TextInputType.text,
      obscureText: _isPasswordVisible,
      controller: widget.controller,

      textDirection: TextDirection.rtl,
      obscuringCharacter: "*",
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: GoogleFonts.ibmPlexSansArabic(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: Color(0xFF7991A4),
      ),
      decoration: InputDecoration(
          prefixIcon:  widget.prefixIcon,
        fillColor: Color(0xFFF7F7F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFFE7EBEF), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFFE7EBEF), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFFE7EBEF), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(width: 1, color: Color(0xFFE84E5D)),
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        hintStyle: GoogleFonts.ibmPlexSansArabic(
          color: Color(0xFF7991A4),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 0.09,
        ),
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? InkWell(
          onTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          child: Icon(
            _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
          ),
        )
            : null,
      ),
    );
  }
}