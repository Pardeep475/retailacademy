import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_strings.dart';
import 'app_text.dart';

class AppButtonWithoutCorner extends StatelessWidget {
  final Color buttonBackgroundColor;
  final Color txtColor;
  final String? title;
  final VoidCallback onPressed;

  const AppButtonWithoutCorner(
      {this.title,
      this.txtColor = Colors.white,
      required this.onPressed,
      this.buttonBackgroundColor = const Color(0xff68C248),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40.h,
        alignment: Alignment.center,
        color: buttonBackgroundColor,
        // padding: EdgeInsets.symmetric(vertical: 12.h),
        child: AppText(
          textAlign: TextAlign.center,
          text: title ?? '',
          color: txtColor,
          fontFamily: AppStrings.robotoFont,
          fontWeight: FontWeight.w700,
          textSize: 12.sp,
        ),
      ),
    );
  }
}
