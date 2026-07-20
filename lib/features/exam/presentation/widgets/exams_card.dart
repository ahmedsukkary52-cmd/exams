import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/image_app.dart';
import '../../../../core/theme/theme_app.dart';
import '../../domain/entities/exam_entity.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({
    super.key,
    required this.exam,
    this.onTap,
  });

  final ExamEntity exam;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final from = exam.createdAt;
    final to = from.add(
      Duration(minutes: exam.duration),
    );

    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ThemeApp.colors.whiteColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2A2929).withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                ImageApp.profit,
                width: 60.w,
                height: 60.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 60.w,
                    height: 60.w,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          exam.title,
                          style: ThemeApp.text.medium16black,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Text(
                        '${exam.duration} Min',
                        style: ThemeApp.text.regular13blue,
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    '${exam.numberOfQuestions} Questions',
                    style: ThemeApp.text.regular13black,
                  ),

                  SizedBox(height: 12.h),

                RichText(
                  text: TextSpan(
                    style: ThemeApp.text.regular14gray,
                    children: [
                      const TextSpan(
                        text: 'From ',
                      ),
                      TextSpan(
                        text: DateFormat('hh:mm a').format(from),
                        style: ThemeApp.text.medium14black,
                      ),
                      const TextSpan(
                        text: '   To ',
                      ),
                      TextSpan(
                        text: DateFormat('hh:mm a').format(to),
                        style: ThemeApp.text.medium14black,
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}