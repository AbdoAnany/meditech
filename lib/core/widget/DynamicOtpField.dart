import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicOtpField extends StatefulWidget {
  final int numberOfFields;
  final double fieldWidth;
  final double fieldHeight;
  final Function(String) onSubmit;

  const DynamicOtpField({
    Key? key,
    this.numberOfFields = 5,
    this.fieldWidth = 70,
    this.fieldHeight = 70,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _DynamicOtpFieldState createState() => _DynamicOtpFieldState();
}

class _DynamicOtpFieldState extends State<DynamicOtpField> {
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = [];
  String? _pastedText;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < widget.numberOfFields; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Handle paste functionality
  Future<void> _handlePaste() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      final String pastedText = data.text!.replaceAll(RegExp(r'[^0-9]'), '');

      if (pastedText.length >= widget.numberOfFields) {
        // Fill all fields with pasted text
        for (int i = 0; i < widget.numberOfFields; i++) {
          _controllers[i].text = pastedText[i];
        }
        // Submit if we have enough characters
        widget.onSubmit(pastedText.substring(0, widget.numberOfFields));
        FocusScope.of(context).unfocus();
      }
    }
  }

  void _onTextChanged(int index, String value) {
    if (value.length > 1) {
      // Handle paste into individual field
      String sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
      if (sanitizedValue.length >= widget.numberOfFields) {
        for (int i = 0; i < widget.numberOfFields; i++) {
          _controllers[i].text = sanitizedValue[i];
        }
        FocusScope.of(context).unfocus();
        widget.onSubmit(sanitizedValue.substring(0, widget.numberOfFields));
        return;
      }
      // If not enough characters, just take the first one
      _controllers[index].text = value[0];
      value = value[0];
    }

    // Handle backspace when field is empty
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].selection = TextSelection.fromPosition(
        TextPosition(offset: _controllers[index - 1].text.length),
      );
      return;
    }

    // Move to next field if value is entered and not last field
    if (value.isNotEmpty && index < widget.numberOfFields - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    // Check if all fields are filled
    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
      String otp = _controllers.map((controller) => controller.text).join();
      FocusScope.of(context).unfocus();
      widget.onSubmit(otp);
    }
  }

  void _onKeyPressed(int index, RawKeyEvent event) {
    // Handle backspace when field is empty
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].selection = TextSelection.fromPosition(
        TextPosition(offset: _controllers[index - 1].text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.numberOfFields, (index) {
        return Container(
          width: widget.fieldWidth.h,
          height: widget.fieldHeight.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) => _onKeyPressed(index, event),
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              maxLength: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.ibmPlexSansArabic(
                color: Color(0xFF1D2035),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                filled: true,
                hintText: "0",
                hintStyle:
               GoogleFonts.ibmPlexSansArabic(
                  color: Color(0xFF7991A4),
              fontSize: 24.sp,

              fontWeight: FontWeight.w700,
              height: 0.26,
            ),
                fillColor: Color(0xFFF7F7F7),
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFFE7EBEF),
                    width: _controllers[index].text.isEmpty
                        ?1: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _controllers[index].text.isEmpty
                        ? Color(0xFFE7EBEF)
                        : Color(0xFF7294FF),
                    width:_controllers[index].text.isEmpty
                        ?1: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFF7294FF),
                    width: _controllers[index].text.isEmpty
                        ?1: 2.0,
                  ),
                ),
              ),
              onChanged: (value) => _onTextChanged(index, value),
              onTap: () {
                if (index > 0 && _controllers[index - 1].text.isEmpty) {
                  _focusNodes[0].requestFocus();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
