import 'package:exams/core/theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
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

  final bool isPassword;
  final bool readOnly;

  final int maxLines;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ThemeApp.colors.blackColor,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _isObscure,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeApp.colors.blackColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,

        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          icon: Icon(
            _isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        )
            : widget.suffixIcon,

        labelStyle: ThemeApp.text.regular14gray,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: ThemeApp.text.regular14gray,
      ),
    );
  }
}