import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';
import 'read_more_text.dart';

class CustomReadMoreText extends StatelessWidget {
  final String value;
  final Color textColor;
  final Color moreTextColor;
  final int trim;
  final EdgeInsetsGeometry? padding;

  const CustomReadMoreText(
      {required this.value,
      this.textColor = AppColor.white,
      this.moreTextColor = AppColor.red,
      this.trim = 2,
      this.padding,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.fromLTRB(16.w, 0, 16.w, 5.h),
      child: ReadMoreText(
        value,
        trimLines: trim,
        colorClickableText: AppColor.lightNavyBlue,
        trimMode: TrimMode.line,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            height: 1.6,
            color: textColor),
        moreStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            height: 1.6,
            color: moreTextColor),
        lessStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            height: 1.6,
            color: moreTextColor),
      ),
    );
  }
}
