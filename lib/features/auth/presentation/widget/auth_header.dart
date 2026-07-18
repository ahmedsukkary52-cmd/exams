import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme_app.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        Text(title, style: ThemeApp.text.medium18black),
        Text(
          description,
          textAlign: TextAlign.center,
          style: ThemeApp.text.regular14gray,
        ),
      ],
    );
  }
}
