import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_app.dart';

class QuestionProgress extends StatelessWidget {
  const QuestionProgress({
    super.key,
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  double get progress {
    if (total == 0) return 0;
    return current / total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4.h,
            backgroundColor: const Color(0xFFE3E6EB),
            valueColor: const AlwaysStoppedAnimation(
              Color(0xFF1842A6),
            ),
          ),
        ),

        SizedBox(height: 8.h),

        Center(
          child: Text(
            'Question $current of $total',
            style: ThemeApp.text.medium14gray,
          ),
        ),
      ],
    );
  }
}