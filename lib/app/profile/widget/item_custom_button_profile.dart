import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widget/app_text.dart';

class ItemCustomButtonProfile extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? textSize;

  const ItemCustomButtonProfile({required this.title,this.textSize, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: AppText(
            text: title,
            textSize: textSize ?? 25.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
