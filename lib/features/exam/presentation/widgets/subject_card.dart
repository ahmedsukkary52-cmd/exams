import 'package:exams/features/exam/domain/entities/subject_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme_app.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    this.onTap, required this.subject,
  });

  final SubjectEntity subject;
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
            Image.network(
              subject.icon,
              width: 48,
              height: 48,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                subject.name,
                style: ThemeApp.text.regular16black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}