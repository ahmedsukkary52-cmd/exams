import 'package:flutter/material.dart';

import '../theme/theme_app.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.hintText = 'Search...',
    this.readOnly = false,
    this.controller,
    this.onTap,
    this.onChanged,
  });

  final String hintText;
  final bool readOnly;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ThemeApp.colors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeApp.colors.grayColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 24,
            color: ThemeApp.colors.lightGrayColor,
          ),
          const SizedBox(width: 4),

          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: ThemeApp.colors.lightGrayColor,
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}