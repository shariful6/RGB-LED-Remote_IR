import 'package:flutter/material.dart';
import 'package:rgbremote/utils/app_color.dart';

class AppTextStyle {
  AppTextStyle._();

  static const kWS10W500 = TextStyle(
    fontSize: 10,
    color: AppColor.kWhiteColor,
    fontWeight: FontWeight.w500,
  );

  static const kWS15W500 = TextStyle(
    fontSize: 15,
    color: AppColor.kWhiteColor,
    fontWeight: FontWeight.w500,
  );

  static const kBS15W500 = TextStyle(
    fontSize: 15,
    color: AppColor.kBlackColor,
    fontWeight: FontWeight.w500,
  );

  static const kGS13W400 = TextStyle(
    fontSize: 13,
    color: AppColor.kGreyColor,
    fontWeight: FontWeight.w400,
  );

  static const kWS14W400 = TextStyle(
    fontSize: 14,
    color: AppColor.kWhiteColor,
    fontWeight: FontWeight.w400,
  );
}