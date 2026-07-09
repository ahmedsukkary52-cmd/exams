import 'package:exams/core/theme/color_app.dart';
import 'package:flutter/material.dart';

class TextApp {
  final AppColors colors;

  const TextApp(this.colors);

  TextStyle _style({
    required Color color,
    required double size,
    required FontWeight weight,
  }) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
    );
  }

  // Black
  TextStyle get semibold20black =>
      _style(color: colors.blackColor, size: 20, weight: FontWeight.w600);

  TextStyle get medium20black =>
      _style(color: colors.blackColor, size: 20, weight: FontWeight.w500);

  TextStyle get medium18black =>
      _style(color: colors.blackColor, size: 18, weight: FontWeight.w500);

  TextStyle get medium16black =>
      _style(color: colors.blackColor, size: 16, weight: FontWeight.w500);

  TextStyle get medium14black =>
      _style(color: colors.blackColor, size: 14, weight: FontWeight.w500);

  TextStyle get medium13black =>
      _style(color: colors.blackColor, size: 13, weight: FontWeight.w500);

  TextStyle get regular16black =>
      _style(color: colors.blackColor, size: 16, weight: FontWeight.w400);

  TextStyle get regular14black =>
      _style(color: colors.blackColor, size: 14, weight: FontWeight.w400);

  TextStyle get regular13black =>
      _style(color: colors.blackColor, size: 13, weight: FontWeight.w400);

  TextStyle get regular12black =>
      _style(color: colors.blackColor, size: 12, weight: FontWeight.w400);

  // Gray
  TextStyle get medium14gray =>
      _style(color: colors.grayColor, size: 14, weight: FontWeight.w500);

  TextStyle get regular14gray =>
      _style(color: colors.grayColor, size: 14, weight: FontWeight.w400);

  TextStyle get regular12gray =>
      _style(color: colors.grayColor, size: 12, weight: FontWeight.w400);

  TextStyle get regular14lightGray =>
      _style(color: colors.lightGrayColor, size: 14, weight: FontWeight.w400);

  // White
  TextStyle get medium16white =>
      _style(color: colors.whiteColor, size: 16, weight: FontWeight.w500);

  TextStyle get medium14white =>
      _style(color: colors.whiteColor, size: 14, weight: FontWeight.w500);

  // Primary
  TextStyle get medium20blue =>
      _style(color: colors.primary, size: 20, weight: FontWeight.w500);

  TextStyle get medium16blue =>
      _style(color: colors.primary, size: 16, weight: FontWeight.w500);

  TextStyle get regular13blue =>
      _style(color: colors.primary, size: 13, weight: FontWeight.w400);

  TextStyle get medium12blue =>
      _style(color: colors.primary, size: 12, weight: FontWeight.w500);

  TextStyle get semibold12blue =>
      _style(color: colors.primary, size: 12, weight: FontWeight.w600);

  // Error
  TextStyle get medium16red =>
      _style(color: colors.errorColor, size: 16, weight: FontWeight.w500);

  TextStyle get regular12red =>
      _style(color: colors.errorColor, size: 12, weight: FontWeight.w400);

  TextStyle get regular20red =>
      _style(color: colors.errorColor, size: 20, weight: FontWeight.w400);

  TextStyle get regular24red =>
      _style(color: colors.errorColor, size: 24, weight: FontWeight.w400);

  // Success
  TextStyle get regular20green =>
      _style(color: colors.greenColor, size: 20, weight: FontWeight.w400);
}