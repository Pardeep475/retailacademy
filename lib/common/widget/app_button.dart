import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app_color.dart';
import '../app_strings.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String txt;
  final Color textColor;
  final String fontFamily;
  final FontWeight fontWeight;
  final double? textSize;
  final Color fillColor;
  final VoidCallback? onPressed;
  final double? width;

   AppButton(
      {required this.txt,
      this.textColor = AppColor.white,
      this.fontFamily = AppStrings.robotoFont,
      this.fontWeight = FontWeight.w600,
      this.textSize,
      this.fillColor = AppColor.buttonFillColor,
      this.width,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width ?? Get.width,
        padding: EdgeInsets.symmetric(vertical: 19.sp),
        decoration: BoxDecoration(
          color: AppColor.buttonFillColor,
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
        ),
        child: AppText(
          text: txt,
          color: textColor,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          textSize: textSize ?? 15.sp,
        ),
      ),
    );
  }

}
