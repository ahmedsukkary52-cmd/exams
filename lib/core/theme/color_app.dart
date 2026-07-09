import 'package:flutter/material.dart';

abstract class AppColors {
  MaterialColor get primary;

  Color get whiteColor;

  MaterialColor get blackColor;

  Color get grayColor;

  Color get lightGrayColor;

  Color get errorColor;

  Color get lightRedColor;

  Color get greenColor;

  Color get lightGreenColor;

  Color get lightBlueColor;

  Color get transparent;
}

class LightThemeColors extends AppColors {
  @override
  MaterialColor get primary => const MaterialColor(0xFF02369C, <int, Color>{
    50: Color(0xFFCCD7EB),
    100: Color(0xFFABBCDE),
    200: Color(0xFF819BCE),
    300: Color(0xFF5679BD),
    400: Color(0xFF2C58AD),
    500: Color(0xFF02369C),
    600: Color(0xFF022D82),
    700: Color(0xFF012468),
    800: Color(0xFF011B4E),
    900: Color(0xFF011234),
    1000: Color(0xFF000B1F),
  });

  @override
  MaterialColor get blackColor => const MaterialColor(0xFF0F0F0F, <int, Color>{
    50: Color(0xFFCFCFCF),
    100: Color(0xFFAFAFAF),
    200: Color(0xFF878787),
    300: Color(0xFF5F5F5F),
    400: Color(0xFF373737),
    500: Color(0xFF0F0F0F),
    600: Color(0xFF0D0D0D),
    700: Color(0xFF0A0A0A),
    800: Color(0xFF080808),
    900: Color(0xFF050505),
    1000: Color(0xFF030303),
  });

  @override
  Color get errorColor => const Color(0xFFCC1010);

  @override
  Color get whiteColor => const Color(0xFFF9F9F9);

  @override
  Color get grayColor => const Color(0xFF535353);

  @override
  Color get lightGrayColor => const Color(0xFFA6A6A6);

  @override
  Color get lightRedColor => const Color(0xFFF8D2D2);

  @override
  Color get greenColor => const Color(0xFF11CE19);

  @override
  Color get lightGreenColor => const Color(0xFFCAF9CC);

  @override
  Color get lightBlueColor => const Color(0xFFEDEFF3);

  @override
  Color get transparent => Colors.transparent;
}