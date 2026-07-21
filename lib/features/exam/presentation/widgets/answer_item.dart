import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme_app.dart';

class AnswerItem extends StatelessWidget {
  const AnswerItem({
    required this.title,
    required this.selected,
  });

  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xffDCE7FA)
            : const Color(0xffF5F7FB),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: selected,
            onChanged: (_) {

            },
          ),
          Expanded(
            child: Text(
              title,
              style: ThemeApp.text.regular16black,
            ),
          ),
        ],
      ),
    );
  }
}
