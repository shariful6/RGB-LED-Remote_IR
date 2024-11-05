import 'package:flutter/material.dart';
import 'package:rgbremote/utils/app_color.dart';

class AppTheme {
  AppTheme._();

  static final dark = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
      primary: AppColor.kPrimaryColor,
    ),
    scaffoldBackgroundColor: AppColor.kPrimaryColor,
    primaryColor: AppColor.kPrimaryColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: AppColor.kPrimaryColor,
      iconTheme: IconThemeData(
        color: AppColor.kWhiteColor,
      ),
    ),
  );
}
