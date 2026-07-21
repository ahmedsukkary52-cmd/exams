import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/question_type.dart';
import '../../../../core/theme/theme_app.dart';
import '../../domain/entities/answer_entity.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.answer,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final AnswerEntity answer;
  final QuestionType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? const Color(0xFF1842A6)
        : const Color(0xFFE5E7EB);

    final backgroundColor = selected
        ? const Color(0xFFDCE7FA)
        : const Color(0xFFF7F8FA);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 18.h,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: borderColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _SelectionIndicator(
                type: type,
                selected: selected,
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Text(
                  answer.answer,
                  style: ThemeApp.text.regular16black.copyWith(
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({
    required this.type,
    required this.selected,
  });

  final QuestionType type;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case QuestionType.single:
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected
                  ? const Color(0xFF1842A6)
                  : const Color(0xFFBFC4CC),
              width: 2,
            ),
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: selected ? 12.w : 0,
              height: selected ? 12.w : 0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1842A6),
              ),
            ),
          ),
        );

      case QuestionType.multiple:
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF1842A6)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              color: selected
                  ? const Color(0xFF1842A6)
                  : const Color(0xFFBFC4CC),
              width: 2,
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: selected
                ? Icon(
              Icons.check,
              key: const ValueKey('checked'),
              color: Colors.white,
              size: 16.sp,
            )
                : const SizedBox(
              key: ValueKey('empty'),
            ),
          ),
        );
    }
  }
}