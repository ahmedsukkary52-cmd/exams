import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_outlined_button.dart';

class ExamBottomActions extends StatelessWidget {
  const ExamBottomActions({
    super.key,
    required this.hasPrevious,
    required this.isLast,
    required this.onBack,
    required this.onNext,
  });

  final bool hasPrevious;
  final bool isLast;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: hasPrevious,
          child: Expanded(
            child: AppOutlinedButton(
              text: 'Back',
              onPressed: hasPrevious ? onBack : null,
            ),
          ),
        ),

        SizedBox(width: 16.w),

        Expanded(
          child: AppElevatedButton(
            text: isLast ? 'Submit' : 'Next',
            onPressed: onNext,
          ),
        ),
      ],
    );
  }
}