import 'package:exams/core/theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
  });

  final String label;
  final String hint;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final bool obscureText;
  final bool readOnly;

  final int maxLines;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ThemeApp.colors.blackColor,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeApp.colors.blackColor),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.r)),
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelStyle: ThemeApp.text.regular14gray,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: ThemeApp.text.regular14gray,
      ),
    );
  }
}
