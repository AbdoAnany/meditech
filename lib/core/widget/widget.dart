import 'package:flutter/material.dart';
import '../style/app_color.dart';
import '../style/app_typography.dart';


class AppWidgets {
  // Tab Bar
  static Widget tabBar({
    required List<Tab> tabs,
    required TabController controller,
    bool isScrollable = false,
  }) {
    return TabBar(
      controller: controller,
      isScrollable: isScrollable,
      labelColor: AppColor.primaryColor,
      unselectedLabelColor: AppColor.lightGrey,
      indicatorColor: AppColor.primaryColor,
      tabs: tabs,
      labelStyle: AppTypography.heading2SemiBold,
      unselectedLabelStyle: AppTypography.heading2Regular,
      padding: EdgeInsets.symmetric(horizontal: AppLayout.gridMargin),
    );
  }

  // Input Field
  static Widget inputField({
    required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool isTextArea = false,
    TextEditingController? controller,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: isTextArea ? 3 : 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTypography.body2.copyWith(color: AppColor.lightGrey1),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColor.lightGrey1)
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: AppColor.lightGrey1)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColor.lighterGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColor.lighterGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
        contentPadding: EdgeInsets.all(AppLayout.spacingMedium),
      ),
      style: AppTypography.body1,
    );
  }

  // Dropdown
  static Widget dropdown({
    required String hintText,
    required List<String> items,
    String? value,
    void Function(String?)? onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hintText, style: AppTypography.body2.copyWith(color: AppColor.lightGrey1)),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: AppTypography.body1),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColor.lighterGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColor.lighterGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
        contentPadding: EdgeInsets.all(AppLayout.spacingMedium),
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppColor.lightGrey1),
    );
  }

  // Slide Controller (Slider)
  static Widget slideController({
    required double min,
    required double max,
    required double value,
    required void Function(double) onChanged,
    required String label,
    String? unit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.heading2Medium),
        Slider(
          min: min,
          max: max,
          value: value,
          onChanged: onChanged,
          activeColor: AppColor.primaryColor,
          inactiveColor: AppColor.lighterGrey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$min${unit ?? ''}', style: AppTypography.body3),
            Text('$max${unit ?? ''}', style: AppTypography.body3),
          ],
        ),
      ],
    );
  }

  // Check Box
  static Widget checkBox({
    required String label,
    required bool value,
    required void Function(bool?) onChanged,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColor.primaryColor,
          checkColor: AppColor.white,
        ),
        Text(label, style: AppTypography.body2),
      ],
    );
  }

  // Compact Card (Already Implemented)
  static Widget card({
    required String name,
    required String specialty,
    required String experience,
    required String rating,
    required void Function() onBookNow,
    Widget? image,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppLayout.spacingMedium),
        child: Row(
          children: [
            image ?? Container(
              width: 80,
              height: 80,
              color: AppColor.lighterGrey,
            ),
            SizedBox(width: AppLayout.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.heading2SemiBold),
                  Text(specialty, style: AppTypography.body2.copyWith(color: AppColor.lightGrey1)),
                  Row(
                    children: [
                      Text(experience, style: AppTypography.body3),
                      SizedBox(width: AppLayout.spacingSmall),
                      Icon(Icons.star, color: AppColor.action, size: 16),
                      Text(rating, style: AppTypography.body3),
                    ],
                  ),
                  SizedBox(height: AppLayout.spacingSmall),
                  ElevatedButton(
                    onPressed: onBookNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('BOOK NOW', style: AppTypography.body2.copyWith(color: AppColor.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Detailed Card (Updated)
// Detailed Card (Updated)
  static Widget detailedCard({
    required String name,
    required String specialty,
    required String experience,
    required String rating,
    required String date,
    required String time,
    required void Function() onClose,
  }) {
    return Card(
      elevation: 2,
      color: AppColor.primaryColor, // Blue background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(AppLayout.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColor.primaryLightColor,
                      child: Text(
                        name.isNotEmpty ? name[0] : 'D',
                        style: AppTypography.heading2SemiBold.copyWith(color: AppColor.white),
                      ),
                    ),
                    SizedBox(width: AppLayout.spacingSmall),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: AppTypography.heading2SemiBold.copyWith(color: AppColor.white),
                          ),
                          Text(
                            specialty,
                            style: AppTypography.body2.copyWith(color: AppColor.white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppLayout.spacingSmall),
                Row(
                  children: [
                    Text(
                      experience,
                      style: AppTypography.body3.copyWith(color: AppColor.white),
                    ),
                    SizedBox(width: AppLayout.spacingSmall),
                    Icon(Icons.star, color: AppColor.action, size: 16),
                    Text(
                      rating,
                      style: AppTypography.body3.copyWith(color: AppColor.white),
                    ),
                  ],
                ),
                SizedBox(height: AppLayout.spacingMedium),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryLightColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppColor.white,
                        ),
                        label: Text(
                          date,
                          style: AppTypography.body2.copyWith(color: AppColor.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColor.transparent,
                          side: BorderSide(color: AppColor.transparent), // Subtle grey border
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppLayout.spacingSmall,
                            vertical: AppLayout.spacingSmall,
                          ),
                        ),
                      ),
                   Expanded(
                     child: Center(
                       child: Container(
                                         decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8.0),
                                         ),
                         width: 1,height: 20,
                       ),
                     ),
                   ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.access_time,
                          size: 16,
                          color: AppColor.white,
                        ),
                        label: Text(
                          time,
                          style: AppTypography.body2.copyWith(color: AppColor.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColor.transparent,
                          side: BorderSide(color: AppColor.transparent), // Subtle grey border
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppLayout.spacingSmall,
                            vertical: AppLayout.spacingSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: AppLayout.spacingSmall,
            right: AppLayout.spacingSmall,
            child: IconButton(
              icon: Icon(Icons.close, color: AppColor.white),
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }

  // Key Number Pad
  static Widget keyNumberPad({
    required void Function(String) onNumberPressed,
    required void Function() onDeletePressed,
    required void Function() onClearPressed,
  }) {
    final List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '+#', '0', ''];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      mainAxisSpacing: AppLayout.spacingSmall,
      crossAxisSpacing: AppLayout.spacingSmall,
      children: numbers.asMap().entries.map((entry) {
        final index = entry.key;
        final number = entry.value;
        if (index == 9) {
          return IconButton(
            icon: Icon(Icons.add, color: AppColor.black),
            onPressed: () => onNumberPressed(number),
          );
        } else if (index == 11) {
          return IconButton(
            icon: Icon(Icons.backspace, color: AppColor.black),
            onPressed: onDeletePressed,
          );
        } else {
          return ElevatedButton(
            onPressed: () => onNumberPressed(number),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.white,
              foregroundColor: AppColor.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: AppColor.lighterGrey),
              ),
            ),
            child: Text(number, style: AppTypography.body1),
          );
        }
      }).toList(),
    );
  }
}