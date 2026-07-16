import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme_app.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        height: 120.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: ThemeApp.colors.whiteColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2A2929).withValues(alpha: 0.25),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.school_rounded,
              size: 48.sp,
              color: ThemeApp.colors.primary,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                title,
                style: ThemeApp.text.regular16black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}