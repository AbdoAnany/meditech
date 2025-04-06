import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget trailing;
  final Function()? onTap;
  final Color? color;

  ProfileListItem({
    required this.icon,
    required this.text,
    this.color,
    this.trailing = const Icon(Icons.arrow_back_ios, size: 16),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        child: Row(
          children: [
            trailing,
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
              child: Text(text,
                  style:
                      TextStyle(color: color ?? Colors.black, fontSize: 18.w)),
            ),
            Icon(
              icon,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
